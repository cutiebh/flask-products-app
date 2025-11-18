from app import app


def test_home_status_code():
    test_client = app.test_client()
    response = test_client.get("/")
    assert response.status_code == 200


def test_home_message():
    test_client = app.test_client()
    response = test_client.get("/")
    data = response.get_json()
    assert data["message"] == "Minimal Flask App is running!"
