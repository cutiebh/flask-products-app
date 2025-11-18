from app import app


def test_integration_info():
    client = app.test_client()
    response = client.get("/api/info")

    assert response.status_code == 200

    data = response.get_json()
    assert data["status"] == "running"
