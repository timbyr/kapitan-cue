package gen


_requests: {
  cpu: string @tag(requests_cpu)
}

_patches: [
  {
    apiVersion: "apps/v1"
    kind:       "Deployment"
    metadata: {
      name: "metrics-server"
      namespace: "kube-system"
    }
    spec: {
      template: {
        spec: {
          containers: [
            {
              name: "metrics-server"
              resources: {
                requests: _requests
              }
            },
          ]
        }
      }
    }
  }
]

