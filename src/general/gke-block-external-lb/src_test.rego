package gkeblockexternallb
test_input_violations {
    input := { "request":  external_lb_output }

    results := violation with input as input
    count(results) == 1
}

test_input_with_internal_lb {
    input := { "request": internal_lb_output }

    results := violation with input as input
    count(results) == 0
}


external_lb_output = output {
  output = {
    "kind": {
        "group": "",
        "version": "v1",
        "kind": "Service",
    },
    "object": external_lb_obj
  }
}

internal_lb_output = output {
  output = {
    "kind": {
        "group": "",
        "version": "v1",
        "kind": "Service",
    },
    "object": internal_lb_obj
  }
}


internal_lb_obj = {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "annotations": {
            "cloud.google.com/load-balancer-type": "Internal",
        },
        "name": "ingress-nginx",
        "namespace": "ingress-nginx",
    },
    "spec": {
        "externalTrafficPolicy": "Local",
        "healthCheckNodePort": 31642,
        "ports": [
            {
                "name": "http",
                "nodePort": 31111,
                "port": 80,
                "protocol": "TCP",
                "targetPort": "http"
            },
            {
                "name": "https",
                "nodePort": 31389,
                "port": 443,
                "protocol": "TCP",
                "targetPort": "https"
            }
        ],
        "selector": {
            "app.kubernetes.io/name": "ingress-nginx",
            "app.kubernetes.io/part-of": "ingress-nginx"
        },
        "sessionAffinity": "None",
        "type": "LoadBalancer"
    },
}

external_lb_obj = {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "name": "ingress-nginx",
        "namespace": "ingress-nginx",
    },
    "spec": {
        "clusterIP": "10.80.124.252",
        "externalTrafficPolicy": "Local",
        "healthCheckNodePort": 31642,
        "ports": [
            {
                "name": "http",
                "nodePort": 31111,
                "port": 80,
                "protocol": "TCP",
                "targetPort": "http"
            },
            {
                "name": "https",
                "nodePort": 31389,
                "port": 443,
                "protocol": "TCP",
                "targetPort": "https"
            }
        ],
        "selector": {
            "app.kubernetes.io/name": "ingress-nginx",
            "app.kubernetes.io/part-of": "ingress-nginx"
        },
        "sessionAffinity": "None",
        "type": "LoadBalancer"
    },
}
