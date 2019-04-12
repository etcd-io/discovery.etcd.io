# Install the CustomResourceDefinition resources separately
kubectl apply -f 00-crds.yaml

# Create the namespace for cert-manager
kubectl create namespace cert-manager

# Label the cert-manager namespace to disable resource validation
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

kubectl apply -f rendered.yaml 
