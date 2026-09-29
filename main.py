from fastapi import FastAPI
app = FastAPI()

@app.get("/")
def read_root():
    return {"routes": ["/hello", "/hello/{name}"]}


@app.get("/hello")
def hello():
    return "Hello World 2"

@app.get("/hello/{name}")
def hello_name(name: str):
    return f"Hello {name}"