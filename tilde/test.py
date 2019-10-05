# -*- encoding: tilde -*-

#import tilde


'''

    exp ~ (1, some_var, (2,3), 'hello')
        is the same as exp == (1, some_var, (2,3), 'hello')

    exp ~ (1, ...)
        three dots at the end - any number of lasst parameters

    exp ~ (int, _, (2, _), 'hello')
        int|str|list|tuple -> matches only things of that type
        _ -> matches anything


    exp ~ (int:x, _, (2, x+1), ...)
        int:x -> matches to integer, and writes output to x
        x+1 -> matches to x set before
        equivalent to:
        type(exp) == tuple and len(exp)>=3 and x:=exp[0] and and exp[2][0] == 0 and exp[2][1]==x+1

    exp ~ (:x, _, :y, ...)
        :var_name - matches anything and writes to :x
        

'''

exp = ('something', 1,0,3)

res = exp ~ ('something', 1, 0 , ... )

EXPR = ('mask_shl', 255, 1, -1, ('and', ('storage', 1, 2, 3), ('add', 1, 2)))
print(EXPR ~ ('mask_shl', 255, 1, -1, ('and', ('storage', ...), ('add', ...))))


#print(res)

exit()

scores = [
    ('John', 'chess', 10),
    ('Alice', 'chess', 20),
    ('Bob', 'sudoku', 500),
    ('Arnold', 'backgammon', 250),
]

for s in scores:

    if s ~ (:name, 'chess', :score) and score > 10:
        print(name, 'is good at chess:', score)

    if s ~ (:name, :game, :score) and game != 'chess':
        print(f'{name} is good at {game}: {score}')


'''

    test2

'''

def run(test, test2):

    if test ~ (int:x, _, x + 2):
        print('first:', x)

    elif test ~ (:x, ...) and \
         test2 ~ (_, (x+1, :y), ...):

        print('second: ', x, y)

    elif test2 ~ (str:x, (2, y), x + 'a', int:y):
        print('third:', x, y)

    else:
        print('fail')

test = (1,2,3)
test2 = ('hah',(2,3),'hahx')

run(test, test2)
# first: 1

test = (1,2,1)
test2 = ('hah',(2,3),'hahx')

run(test, test2)
# second:  1 3

test = (9,0,0)
test2 = ('hah',(2, 3),'haha', 3)

run(test, test2)
# third: hah 3