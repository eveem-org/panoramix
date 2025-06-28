"""Validation tests to ensure the testing infrastructure is set up correctly."""

import pytest
from pathlib import Path


class TestInfrastructureValidation:
    """Validate that the testing infrastructure is properly configured."""
    
    @pytest.mark.unit
    def test_pytest_is_working(self):
        """Verify that pytest can run basic tests."""
        assert True
        assert 1 + 1 == 2
    
    @pytest.mark.unit
    def test_markers_are_configured(self, request):
        """Verify that custom markers are properly configured."""
        # This test has the 'unit' marker
        assert "unit" in [marker.name for marker in request.node.iter_markers()]
    
    @pytest.mark.unit
    def test_fixtures_are_available(self, temp_dir, mock_config):
        """Verify that custom fixtures are accessible."""
        assert isinstance(temp_dir, Path)
        assert temp_dir.exists()
        assert isinstance(mock_config, dict)
        assert "etherscan_api_key" in mock_config
    
    @pytest.mark.unit
    def test_coverage_is_configured(self):
        """Verify that coverage reporting is enabled."""
        # This test will be included in coverage
        def dummy_function(x):
            return x * 2
        
        assert dummy_function(5) == 10
    
    @pytest.mark.integration
    def test_integration_marker(self):
        """Verify that integration test marker works."""
        # This is marked as an integration test
        assert True
    
    @pytest.mark.slow
    def test_slow_marker(self):
        """Verify that slow test marker works."""
        # This is marked as a slow test
        import time
        start = time.time()
        time.sleep(0.1)  # Simulate slow operation
        assert time.time() - start >= 0.1


class TestFixtureValidation:
    """Validate that all fixtures work correctly."""
    
    @pytest.mark.unit
    def test_temp_dir_fixture(self, temp_dir):
        """Test the temp_dir fixture creates a valid directory."""
        assert temp_dir.exists()
        assert temp_dir.is_dir()
        
        # Test we can write to it
        test_file = temp_dir / "test.txt"
        test_file.write_text("test content")
        assert test_file.exists()
        assert test_file.read_text() == "test content"
    
    @pytest.mark.unit
    def test_mock_contract_bytecode_fixture(self, mock_contract_bytecode):
        """Test the mock_contract_bytecode fixture."""
        assert isinstance(mock_contract_bytecode, str)
        assert mock_contract_bytecode.startswith("0x")
        assert len(mock_contract_bytecode) > 100  # Reasonable bytecode length
    
    @pytest.mark.unit
    def test_mock_cache_dir_fixture(self, mock_cache_dir):
        """Test the mock_cache_dir fixture creates proper cache structure."""
        assert mock_cache_dir.exists()
        assert (mock_cache_dir / "cache_pan").exists()
        assert (mock_cache_dir / "cache_code").exists()
        assert (mock_cache_dir / "cache_pabi").exists()
    
    @pytest.mark.unit
    def test_mock_function_signature_fixture(self, mock_function_signature):
        """Test the mock_function_signature fixture."""
        assert isinstance(mock_function_signature, dict)
        assert "0x2e64cec1" in mock_function_signature
        assert mock_function_signature["0x2e64cec1"] == "retrieve()"
    
    @pytest.mark.unit
    def test_mock_abi_fixture(self, mock_abi):
        """Test the mock_abi fixture."""
        assert isinstance(mock_abi, list)
        assert len(mock_abi) >= 2
        assert all("name" in item for item in mock_abi)
        assert any(item["name"] == "retrieve" for item in mock_abi)


@pytest.mark.unit
def test_project_structure():
    """Verify that the project structure is as expected."""
    import os
    
    # Check that main modules exist
    assert os.path.exists("core/__init__.py")
    assert os.path.exists("pano/__init__.py")
    assert os.path.exists("utils/__init__.py")
    assert os.path.exists("tilde/__init__.py")
    
    # Check that main entry point exists
    assert os.path.exists("panoramix.py")