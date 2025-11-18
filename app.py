from flask import Flask

app = Flask(__name__)


@app.route("/")
def home():
    return """
    <html>
        <head>
            <title>Cutie's Products App</title>
        </head>
        <body style="font-family: Arial; margin: 40px;">
            <h1>Welcome to Cutie's Products App</h1>
            <p>
                This server is running on AWS EC2 instance and deployed automatically 
                using Terraform & GitHub Actions.
            </p>
            <hr>
            <p>Status: <strong>Online</strong></p>
        </body>
    </html>
    """


@app.route("/api/info")
def info():
    return {
        "service": "Cutie's Products App",
        "status": "running"
    }


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
