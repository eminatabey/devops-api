from fastapi import FastAPI

from app.config import settings
from app.routes import router
from app.security import SecurityHeadersMiddleware, TrustedHostMiddleware

app = FastAPI(
    title=settings.app_name,
    version=settings.app_version,
    docs_url="/docs" if settings.debug else None,
    redoc_url=None,
)

# Security middlewares
app.add_middleware(SecurityHeadersMiddleware)
app.add_middleware(TrustedHostMiddleware)

# Routes registration
app.include_router(router, prefix=settings.api_prefix)


@app.get("/")
async def root():
    return {"message": f"{settings.app_name} - {settings.environment}"}
