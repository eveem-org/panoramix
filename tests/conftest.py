"""Shared pytest fixtures and configuration for Panoramix tests."""

import os
import tempfile
from pathlib import Path
from typing import Generator, Dict, Any

import pytest


@pytest.fixture
def temp_dir() -> Generator[Path, None, None]:
    """Create a temporary directory for test files."""
    with tempfile.TemporaryDirectory() as tmpdir:
        yield Path(tmpdir)


@pytest.fixture
def mock_contract_bytecode() -> str:
    """Sample Ethereum contract bytecode for testing."""
    # Simple storage contract bytecode
    return "0x608060405234801561001057600080fd5b50610150806100206000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c80632e64cec11461003b5780636057361d14610059575b600080fd5b610043610075565b60405161005091906100d9565b60405180910390f35b610073600480360381019061006e919061009d565b61007e565b005b60008054905090565b8060008190555050565b60008135905061009781610103565b92915050565b6000602082840312156100b3576100b26100fe565b5b60006100c184828501610088565b91505092915050565b6100d3816100f4565b82525050565b60006020820190506100ee60008301846100ca565b92915050565b6000819050919050565b600080fd5b61010c816100f4565b811461011757600080fd5b5056fea2646970667358221220"


@pytest.fixture
def mock_contract_address() -> str:
    """Sample Ethereum contract address for testing."""
    return "0x1234567890123456789012345678901234567890"


@pytest.fixture
def mock_cache_dir(temp_dir: Path) -> Path:
    """Create mock cache directories for testing."""
    cache_pan = temp_dir / "cache_pan"
    cache_code = temp_dir / "cache_code"
    cache_pabi = temp_dir / "cache_pabi"
    
    cache_pan.mkdir()
    cache_code.mkdir()
    cache_pabi.mkdir()
    
    return temp_dir


@pytest.fixture
def mock_config() -> Dict[str, Any]:
    """Mock configuration dictionary for testing."""
    return {
        "etherscan_api_key": "test_api_key",
        "infura_url": "https://mainnet.infura.io/v3/test_project_id",
        "timeout": 30,
        "cache_enabled": True,
        "debug": False,
    }


@pytest.fixture
def mock_function_signature() -> Dict[str, str]:
    """Mock function signature data for testing."""
    return {
        "0x2e64cec1": "retrieve()",
        "0x6057361d": "store(uint256)",
        "0xa9059cbb": "transfer(address,uint256)",
        "0x70a08231": "balanceOf(address)",
    }


@pytest.fixture
def mock_opcode_sequence() -> list:
    """Mock EVM opcode sequence for testing."""
    return [
        ("PUSH1", "0x80"),
        ("PUSH1", "0x40"),
        ("MSTORE", None),
        ("CALLVALUE", None),
        ("DUP1", None),
        ("ISZERO", None),
        ("PUSH2", "0x0010"),
        ("JUMPI", None),
    ]


@pytest.fixture
def mock_storage_slot() -> Dict[str, Any]:
    """Mock storage slot information for testing."""
    return {
        "slot": 0,
        "offset": 0,
        "type": "uint256",
        "value": "0x0000000000000000000000000000000000000000000000000000000000000005",
    }


@pytest.fixture
def mock_abi() -> list:
    """Mock contract ABI for testing."""
    return [
        {
            "inputs": [],
            "name": "retrieve",
            "outputs": [{"internalType": "uint256", "name": "", "type": "uint256"}],
            "stateMutability": "view",
            "type": "function",
        },
        {
            "inputs": [{"internalType": "uint256", "name": "num", "type": "uint256"}],
            "name": "store",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function",
        },
    ]


@pytest.fixture(autouse=True)
def reset_environment(monkeypatch):
    """Reset environment variables for each test."""
    # Clear any existing API keys or sensitive data
    monkeypatch.delenv("ETHERSCAN_API_KEY", raising=False)
    monkeypatch.delenv("INFURA_PROJECT_ID", raising=False)
    monkeypatch.delenv("WEB3_PROVIDER_URL", raising=False)


@pytest.fixture
def isolated_filesystem(tmp_path):
    """Create an isolated filesystem for testing file operations."""
    original_cwd = os.getcwd()
    os.chdir(tmp_path)
    yield tmp_path
    os.chdir(original_cwd)


# Markers for test categorization
def pytest_configure(config):
    """Register custom markers."""
    config.addinivalue_line("markers", "unit: Unit tests")
    config.addinivalue_line("markers", "integration: Integration tests")
    config.addinivalue_line("markers", "slow: Slow running tests")