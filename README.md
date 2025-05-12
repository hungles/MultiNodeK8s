# Infrastructure and Kubernetes Automation on AWS

This repository provides an automated solution to provision infrastructure on AWS and deploy a highly available Kubernetes cluster. The entire workflow is orchestrated by a Bash script (`setup.sh`) that integrates **Terraform** for resource provisioning and **Ansible** for node configuration.

---

## 📋 Table of Contents

* [Overview](#overview)
* [Architecture](#architecture)
* [Prerequisites](#prerequisites)
* [Project Structure](#project-structure)
* [Installation & Usage](#installation--usage)

  * [Environment Variables](#environment-variables)
  * [Running the Script](#running-the-script)
* [Resource Cleanup](#resource-cleanup)
* [Contributing](#contributing)
* [License](#license)

---

## 📖 Overview

This tool automates the following tasks:

1. **Provisioning** AWS EC2 instances:

   * 2 control plane nodes (HA)
   * 2 worker nodes
   * You can configure more Control and worker nodes by configuring the `main.tf` file in the `terraform/` directory.
2. **Configuring** the Kubernetes cluster with Ansible.
3. **Orchestrating** the entire process via a Bash script (`setup`).

With a single command, you can spin up and configure a production-ready Kubernetes cluster on AWS.

> ⚠️ **Important**: The instances used for the implementation are of type `t2.medium`. These instances may incur costs depending on your AWS account type (e.g., outside of Free Tier). Please take appropriate measures to monitor and control usage and costs.

## 🏗️ Architecture

```
┌────────────┐       ┌──────────────┐
│  setup.sh  │────▶  │   Terraform  │
│  (Bash)    │       └──────────────┘
└────────────┘                │
                              ▼
                       AWS EC2 Instances
                (2 control plane nodes, 2 worker nodes)
                              │
                              ▼
                          Ansible
                              │
                              ▼
                   Kubernetes Cluster (HA)
```

## ⚙️ Prerequisites

Before you begin, ensure you have the following installed and configured:

* **AWS CLI** (configured with valid credentials and default region)
* **Terraform** (v1.0.0 or later)
* **Ansible** (v2.9 or later)
* **SSH** (private and public key with access to EC2 instances)
* **Bash** (to execute `setup`)

## 📂 Project Structure

```
├── ansible/
│   ├── ansible.cfg             # Static or dynamic inventory
│   ├── playbooks/
│   │   ├── 01-preconfig_kubernetes_servers.yml # Playbook for control plane nodes
│   │   └── 02-configure_nodes.yml  # Playbook for worker nodes
│   └── roles/                # Reusable Ansible roles
│       ├── common/
│       ├── k8s/
│       └── ...
├── terraform/
│   ├── main.tf               # AWS resource definitions
│   ├── variables.tf          # Variable declarations
│   └── outputs.tf            # Terraform outputs
├── setup.sh                  # Main orchestration script
└── README.md                 # This file
```

## 🚀 Installation & Usage

### Environment Variables

Set the following environment variables (or create a `.env` file):

```bash
export AWS_ACCESS_KEY_ID="<YOUR_ACCESS_KEY_ID>"
export AWS_SECRET_ACCESS_KEY="<YOUR_SECRET_ACCESS_KEY>"
export AWS_DEFAULT_REGION="us-east-1"
export SSH_PRIVATE_KEY_PATH="~/.ssh/id_rsa"
```

### Running the Script

Make the script executable and run it:

```bash
chmod +x setup
./setup
```

This will automatically perform:

1. `terraform init` and `terraform apply` to create EC2 instances.
2. Generate an Ansible inventory.
3. Execute Ansible playbooks to install and configure the Kubernetes cluster.

---

## 🧹 Resource Cleanup

To destroy all AWS resources created:

```bash
cd terraform
terraform destroy --auto-approve
```

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch:

```bash
git checkout -b feature/your-feature-name
```
3. Commit your changes:
```bash
git commit -m "Add awesome feature"
```

4. Push to your branch and open a Pull Request.

---

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
