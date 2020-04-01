FROM registry.svc.ci.openshift.org/openshift/release:golang-1.12 AS builder
WORKDIR /go/src/github.com/openshift/cluster-svcat-apiserver-operator
COPY . .
RUN GODEBUG=tls13=1 go build ./cmd/cluster-svcat-apiserver-operator

FROM registry.svc.ci.openshift.org/openshift/origin-v4.0:base
COPY --from=builder /go/src/github.com/openshift/cluster-svcat-apiserver-operator/cluster-svcat-apiserver-operator /usr/bin/
COPY manifests /manifests
COPY vendor/github.com/openshift/api/operator/v1/0000_50_cluster-svcat-apiserver-operator_02_config.crd.yaml /manifests
LABEL io.openshift.release.operator true
