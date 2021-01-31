package gkeblockexternallb

test_input_violations {
    input := { "review": external_lb_output }

    results := violation with input as input
    count(results) == 1
}

test_input_violations_with_annotations {
    input := { "review": external_lb_output_with_annotations }

    results := violation with input as input
    count(results) == 1
}

test_input_with_internal_lb {
    input := { "review": internal_lb_output }

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

external_lb_output_with_annotations = output {
  output = {
    "kind": {
        "group": "",
        "version": "v1",
        "kind": "Service",
    },
    "object": external_lb_obj_with_annotations
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


external_lb_obj_with_annotations = {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "name": "ingress-nginx",
        "namespace": "ingress-nginx",
        "annotations": {
            "cloud.google.com/load-balancer-type": "something",
        },
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
