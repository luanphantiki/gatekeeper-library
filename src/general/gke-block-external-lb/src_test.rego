package gkeblockexternallb

test_input_violations_without_annotations {
    input := { "request":  gke_external_lb}

    results := violation with input as input
    count(results) == 1
}

test_input_violations_with_annotations {
    input := { "request":  gke_external_lb_with_annotations }

    results := violation with input as input
    count(results) == 1
}

test_input_non_svc {
    input := { "request":  non_svc }

    results := violation with input as input
    count(results) == 0
}

test_input_with_internal_lb{
    input := { "request": gke_internal_lb }

    results := violation with input as input
    count(results) == 0
}

non_svc = output {
  output = {
    "kind": {
        "group": "",
        "version": "v1",
        "kind": "Foo",
    },
    "object": {
      "metadata": {
        "name": "bar",
      },
      "spec": {
          "externalIPs": ["1.1.1.1"],
      }
    }
  }
}


gke_external_lb = output {
  output = {
    "kind": {
        "group": "",
        "version": "v1",
        "kind": "Service",
    },
    "object": {
      "metadata": {
        "name": "bar",
      },
      "spec": {
          "selector": "MyApp",
          "ports": [{
              "name": "http",
              "protocol": "TCP",
              "port": 80,
              "targetPort": 8080,
          }],
          "type": "LoadBalancer",
      }
    }
  }
}

gke_internal_lb = output {
  output = {
    "kind": {
        "group": "",
        "version": "v1",
        "kind": "Service",
    },
    "object": {
      "metadata": {
        "name": "bar",
        "annotations": {
            "cloud.google.com/load-balancer-type": "Internal",
            "foo": "bar",
        }
      },
      "spec": {
          "selector": "MyApp",
          "ports": [{
              "name": "http",
              "protocol": "TCP",
              "port": 80,
              "targetPort": 8080,
          }],
          "type": "LoadBalancer",
      }
    }
  }
}

gke_external_lb_with_annotations = output {
  output = {
    "kind": {
        "group": "",
        "version": "v1",
        "kind": "Service",
    },
    "object": {
      "metadata": {
        "name": "bar",
        "annotations": {
            "foo": "bar",
        }
      },
      "spec": {
          "selector": "MyApp",
          "ports": [{
              "name": "http",
              "protocol": "TCP",
              "port": 80,
              "targetPort": 8080,
          }],
          "type": "LoadBalancer",
      }
    }
  }
}
