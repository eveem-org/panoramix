import sqlite3
import json
from zipfile import ZipFile
import urllib.request
import sys
import time
import os

from .helpers import opcode, padded_hex, cached
from .helpers import COLOR_HEADER, COLOR_BLUE, COLOR_OKGREEN, COLOR_WARNING, FAIL, ENDC, COLOR_BOLD, COLOR_UNDERLINE, COLOR_GREEN, COLOR_GRAY


'''
    a module for management of bytes4 signatures from the database

     db schema:

     hash - 0x12345678
     name - transferFrom
     folded_name - transferFrom(address,address,uint256)
     cooccurs - comma-dellimeted list of hashes: `0x12312312,0xabababab...`
     params - json: `[
            {
              "type": "address",
              "name": "_from"
            },
            {
              "type": "address",
              "name": "_to"
            },
            {
              "type": "uint256",
              "name": "_value"
            }
          ]`

'''

conn = None

def check_supplements():
    if not os.path.isfile('supplement.db'):
        print(COLOR_OKGREEN+'Hello, is this your first Panoramix run?'+ENDC)
        print()
        print('I need to fetch the signatures database from the web')
        print('This will be done just once.')
        print()
        fetch_db()

    assert os.path.isfile('supplement.db')

    if not os.path.isfile('supp2.db'):
        print('creating supp2.db...')
        c = sqlite3.connect('supplement.db').cursor()
        d_conn = sqlite3.connect('supp2.db')
        d = d_conn.cursor()

        d.execute('create table functions (hash integer, name text, folded_name text, params text, primary KEY(hash))')

        c.execute('SELECT hash, name, folded_name, params from functions group by hash')
        results = c.fetchall()

        for r in results:
            insert_row = int(r[0], 16), r[1], r[2], r[3]
            d.execute('INSERT INTO functions VALUES (?, ?, ?, ?)', insert_row)

        d_conn.commit()
        d_conn.close()
        print('done.')

    assert os.path.isfile('supp2.db')

def _cursor():
    global conn

    check_supplements()

    if conn is None:
        conn = sqlite3.connect('supplement.db')

    try:
        c = conn.cursor()
    except:
        # fails in multi-threading, this should help
        conn = sqlite3.connect('supplement.db')
        return conn.cursor()

    return c

conn2 = None

def _cursor2():
    global conn2

    check_supplements()

    if conn2 is None:
        conn2 = sqlite3.connect('supp2.db')

    try:
        c = conn2.cursor()
    except:
        # fails in multi-threading, this should help
        conn2 = sqlite3.connect('supp2.db')
        return conn2.cursor()

    return c

@cached
def fetch_sigs(hash):
    c = _cursor()
    c.execute('SELECT * from functions where hash=?', (hash,))
    
    results = c.fetchall()

    res = []
    for row in results:
        res.append({
                'hash': row[0],
                'name': row[1],
                'folded_name': row[2],
                'params': json.loads(row[3]),
                'cooccurs': row[4].split(','),
            })

    return res

@cached
def fetch_sig(hash):
    if type(hash) == str:
        hash = int(hash, 16)

    c = _cursor2()
    c.execute(f'SELECT hash, name, folded_name, params from functions where hash={hash}')

    results = c.fetchall()
    if len(results) == 0:
        return None

    row = results[0]

    return {
        'hash': padded_hex(row[0], 8),
        'name': row[1],
        'folded_name': row[2],
        'params': json.loads(row[3]),
    }


def fetch_db():
    def reporthook(count, block_size, total_size):
        # https://blog.shichao.io/2012/10/04/progress_speed_indicator_for_urlretrieve_in_python.html
        global start_time
        if count == 0:
            start_time = time.time()
            return

        duration = time.time() - start_time
        progress_size = int(count * block_size)
        speed = int(progress_size / (1024 * duration))
        percent = min(int((count * block_size * 100) / total_size), 100)
        sys.stdout.write("\r%d of 27 MB, %d KB/s, %d seconds passed..." %
                        (progress_size / (1024 * 1024), speed, duration))
        sys.stdout.flush()

    print('fetching supplement.zip...')
    url = 'http://eveem.org/static/supplement.zip'
    urllib.request.urlretrieve(url, 'tmp.supplement.db.zip', reporthook)
    print('')
    print('unzipping into supplement.db...')
    with ZipFile('tmp.supplement.db.zip') as myzip:
        with myzip.open('supplement.db') as myfile:
            with open('supplement.db', 'wb') as file:
                file.write(myfile.read())

    os.remove('tmp.supplement.db.zip')
    print('done.')

def create_db():
    c = _cursor()

    c.execute('''create TABLE functions
                 (hash text, name text, folded_name text, params text, cooccurs text)''')

    c.execute('''create INDEX hash_idx ON functions (hash)''')

    with open('supplement.json') as f:
        data = json.loads(f.read())

    num = 0
    for f_hash, val in data.items():
        for f in val:
            num += 1
            print(f'adding {num}...')
            row = (
                f_hash,
                f['name'],
                f['folded_name'],
                json.dumps(f['params']),
                ','.join(f['cooccurs']))

    #       print(row)

            c.execute('INSERT INTO functions VALUES (?, ?, ?, ?, ?)', row)

    conn.commit()


