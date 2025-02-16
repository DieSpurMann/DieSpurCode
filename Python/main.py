import fastapi as fa
from supabase import create_client, Client

url = "https://pczyoeavtwijgtkzgcaz.supabase.co"
key ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBjenlvZWF2dHdpamd0a3pnY2F6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEzOTc1NTUsImV4cCI6MjA0Njk3MzU1NX0._KJBbSHWivEF6VrPdyO3TUI729c0eXnj-zoVeQmFYQc"


app = fa.FastAPI()

@app.get("/")
async def read_root():
    return {"message": "This is a FastAPI application."}

@app.get("/books")
async def FetchBooks():
    # Create a client to connect to the database
    supabase: Client = create_client(url, key)
    # Fetch the data to get the liked books of the user 
    response = supabase.table('book').select('*').execute()
    return response.data

@app.get("/authors")
async def FetchAuthors():
    # Create a client to connect to the database
    supabase: Client = create_client(url, key)
    # Fetch the data to get the liked books of the user 
    response = supabase.table('author').select('*').execute()
    return response.data

@app.get("/authors/{author_name}")
async def get_user(author_name: str):
    # FastAPI automatically extracts `user_id` from the URL path and injects it into the function as an integer.
    # Create a client to connect to the database
    supabase: Client = create_client(url, key)
    # Fetch the data to get the liked books of the user 
    response = supabase.table('author').select('book_author(), book(*)').eq("author_name", author_name).execute()
    return response.data
