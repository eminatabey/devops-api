from pydantic import BaseModel


class HealthResponse(BaseModel):
    status: str
    version: str
    environment: str


class ServiceStatus(BaseModel):
    name: str
    status: str
    details: str | None = None


class InfraStatusResponse(BaseModel):
    services: list[ServiceStatus]
    overall: str
