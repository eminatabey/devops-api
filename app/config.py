from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    app_name: str = "DevOps API"
    app_version: str = "1.0.0"
    environment: str = "development"
    debug: bool = False
    allowed_hosts: list[str] = ["*"]
    api_prefix: str = "/api/v1"

    model_config = {"env_prefix": "APP_"}


settings = Settings()
