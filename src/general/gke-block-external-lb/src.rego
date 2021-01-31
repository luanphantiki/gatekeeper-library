package gkeblockexternallb

violation[{"msg": msg}] {
    input.review.object.kind == "Service"
    service := input.review.object
    service.spec.type == "LoadBalancer"
    not service.metadata.annotations["cloud.google.com/load-balancer-type"] == "Internal"

    msg := sprintf("Only internal loadbalancer is allowed:  %v", [service.metadata.name])
}
