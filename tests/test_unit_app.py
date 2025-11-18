from app import app


def test_info_status_code():
    test_client = app.test_client()
    response = test_client.get("/api/info")
    assert response.status_code == 200


def test_info_message():
    test_client = app.test_client()
    response = test_client.get("/api/info")
    data = response.get_json()
    assert data["service"] == "Cutie's Products App"
