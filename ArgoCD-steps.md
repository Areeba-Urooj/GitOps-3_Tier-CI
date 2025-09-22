# 🔧 DevOps Tooling Setup Guide on Linux 

This guide provides the commands to install and configure Argo CD on a Kubernetes cluster.

# 📦 Install Argo CD
This command deploys all the necessary Argo CD components (server, controller, Redis) into a dedicated argocd namespace.

Bash

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# 🌐 Expose the Argo CD Server
By default, the Argo CD server is a ClusterIP service, meaning it's only accessible from within the cluster. You need to change it to a LoadBalancer to expose it externally.

Bash

kubectl -n argocd patch svc argocd-server -p '{"spec": {"type": "LoadBalancer"}}'
Note: You can also use kubectl edit to manually change the service type. Wait a few minutes for the Load Balancer to provision.

# 🔐 Log In for the First Time
# 1. Retrieve the Initial Password
The initial admin password is created as a Kubernetes secret. Use this command to retrieve and decode it.

Bash

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
# 2. Get the Argo CD Server URL
Find the external endpoint of the Argo CD server. Look for the EXTERNAL-IP of the argocd-server service.

Bash

kubectl get all -n argocd
# 3. Log In
Use the EXTERNAL-IP and the password from the previous steps to log in to the Argo CD UI in your browser. The default username is admin.

🤖 Automate Sync with GitHub Webhooks
This allows GitHub to automatically notify Argo CD of new changes, triggering an immediate sync.

# 1. Generate and Patch the Secret
First, create a secret on your local machine and then use it to patch the argocd-secret in your cluster. This tells Argo CD what secret to expect from GitHub.

Bash

SECRET="<YOUR_STRONG_SECRET>"
kubectl -n argocd patch secret argocd-secret --type merge -p '{"stringData":{"webhook.github.secret":"'"$SECRET"'"}}'
Note: Replace <YOUR_STRONG_SECRET> with a unique, secure password.

# 2. Configure the GitHub Webhook
Go to your repository settings on GitHub and add a new webhook.

Payload URL: The external URL of your Argo CD server, with /api/webhook appended.

Secret: Paste the exact same secret you used in the previous step.
