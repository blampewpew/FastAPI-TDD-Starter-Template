import os

import pytest as pytest
from fastapi.testclient import TestClient

from app import main
from app.core.config import Settings
from app.main import get_settings


def get_settings_override():
    return Settings(TESTING=1, DATABASE_URL=os.environ.get("DATABASE_TEST_URL"))


@pytest.fixture(scope="module")
def test_app():
    main.app.dependency_overrides[get_settings] = get_settings_override
    with TestClient(main.app) as test_client:
        yield test_client
