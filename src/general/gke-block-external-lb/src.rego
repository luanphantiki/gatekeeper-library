package gkeblockexternallb

violation[{"msg": msg}] {
    input.request.kind.kind == "Service"
    input.request.object.spec.type == "LoadBalancer"
    not input.request.object.metadata.annotations["cloud.google.com/load-balancer-type"] == "Internal"

    msg := "err, gke LoadBalancer must have Internal annotation."
}
