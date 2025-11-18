from flask import Flask, jsonify

app = Flask(__name__)


""" @app.route("/")
def home():
    return jsonify({"message": "Cutie's Flask App is running!"})
 """

@app.route("/")
def home():
    return """
    <html>
        <head>
            <title>Flask Products App</title>
        </head>
        <body style="font-family: Arial; margin: 40px;">
            <h1>Welcome to Flask Products App</h1>
            <p>This server is running on EC2 and deployed automatically using Terraform & GitHub Actions.</p>
            <hr>
            <p>Status: <strong>Online</strong></p>
        </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
