import json
from app import app

def test_integration_home():
    client = app.test_client()

    # Full request → response cycle
    response = client.get("/")
    assert response.status_code == 200

    data = response.get_json()
    assert "message" in data
    assert "running" in data["message"]
