from fastapi import FastAPI
app = FastAPI()

@app.get("/")
def read_root():
    return {"routes": "/hello"}


@app.get("/hello")
def hello():
    return "Hello World!"

