import azure.functions as func

# Initial example of an HTTP Azure Function

def main(req: func.HttpRequest) -> func.HttpResponse:
    return func.HttpResponse(
        "Photo Portfolio Manager backend is working.",
        status_code=200,
    )
