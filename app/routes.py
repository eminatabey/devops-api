from fastapi import APIRouter

from app.config import settings
from app.models import HealthResponse, InfraStatusResponse, ServiceStatus

router = APIRouter()


@router.get("/health", response_model=HealthResponse)
async def health_check():
    """Health endpoint for Kubernetes probes (liveness/readiness)."""
    return HealthResponse(
        status="healthy",
        version=settings.app_version,
        environment=settings.environment,
    )


@router.get("/infra/status", response_model=InfraStatusResponse)
async def infra_status():
    """Returns the simulated status of infrastructure services."""
    services = [
        ServiceStatus(name="database", status="up", details="PostgreSQL 16"),
        ServiceStatus(name="cache", status="up", details="Redis 7"),
        ServiceStatus(name="storage", status="up", details="S3-compatible"),
        ServiceStatus(name="monitoring", status="up", details="Prometheus + Grafana"),
    ]
    overall = "healthy" if all(s.status == "up" for s in services) else "degraded"
    return InfraStatusResponse(services=services, overall=overall)


@router.get("/security/audit")
async def security_audit():
    """Returns a simplified security audit report."""
    return {
        "tls_enforced": True,
        "rbac_enabled": True,
        "network_policies": True,
        "secrets_encrypted": True,
        "pod_security_standards": "restricted",
        "image_scanning": "enabled",
        "audit_logging": "enabled",
        "recommendations": [
            "Rotate secrets every 90 days",
            "Update base images monthly",
            "Review NetworkPolicies quarterly",
        ],
    }
