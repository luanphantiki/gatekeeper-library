package gkeblockexternallb

violation[{"msg": msg}] {
    input.review.object.kind == "Service"
    input.review.object.spec.type == "LoadBalancer"
    service := input.review.object
    anno := "cloud.google.com/load-balancer-type"
    missing(service.metadata.annotations, anno)

    msg := sprintf("Only internal loadbalancer is allowed:  %v", [service.metadata.name])
}

missing(obj, field) = true {
  not obj[field]
}

missing(obj, field) = true {
  not obj[field] == "Internal"
}
