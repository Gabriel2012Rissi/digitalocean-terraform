# Cluster Kubernetes na DigitalOcean com Terraform

### Vagrant

1. Para usar o [Vagrant](https://www.vagrantup.com) é necessário primeiramente efetuar a instalação da ferramenta.

```
$ wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
$ echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
$ sudo apt update && sudo apt install vagrant
```

2. Para provisionar a box use o comando:

```
vagrant provision
```

3. Para acessar a sua máquina virtual via SSH, use:

```
vagrant ssh
```

### Usando Terraform com Docker

Para utilizar o [Terraform](https://github.com/hashicorp/terraform) com o [docker-compose](https://docs.docker.com/compose/install), siga os passos a seguir:

1. Inicialize o [Terraform](https://github.com/hashicorp/terraform) com o comando:

```
docker-compose run --rm terraform init -backend-config=config.remote.tfbackend
```

**Observação:** Não se esqueça de preencher corretarmente o arquivo 'backend.tf'.

2. Para planejar a infraestrutura, utilize o comando:

```
docker-compose run --rm terraform plan
```

3. Para aplicar a infraestrutura, utilize o comando:

```
docker-compose run --rm terraform apply
```

4. Para adicionar o 'kube_config.yaml' gerado pelo Terraform e testar com o ['kubectl'](https://kubernetes.io/docs/reference/kubectl/kubectl/), use os comandos:

```
mv ~/.kube/config ~/.kube/config.backup
mv terraform/files/kube_config.yaml ~/.kube/config
kubectl get nodes
```

5. Agora é a hora de testar o nosso cluster, para isso, use a sequência:

```
cd git
git clone https://github.com/Gabriel2012Rissi/conversao-temperatura-kubemanifest.git
cd conversao-temperatura-kubemanifest

# Aplicando os manifests
kubectl create namespace conversao-temperatura
kubectl apply -f ./deployment.yaml --namespace conversao-temperatura
kubectl get all --namespace conversao-temperatura
```

6. Para acessar a aplicação, basta criar um 'ip reservado'.

**Observação:** Usar 'NodePort' do [Kubernetes](https://kubernetes.io/pt-br) nos services com um 'ip reservado' poderá representar uma boa economia, caso não seja necessário um 'load balance' atrelado... :wink:

7. Finalmente está na hora de destruir a nossa infraestrutura, para isso use o comando:

```
docker-compose run --rm terraform destroy
```

### Referências

FABRÍCIO VERONEZ DEVOPS PRO. Jornada DevOps de Elite - Aula 3 - O que o mercado espera de você?. YouTube, 19 de Out. 2022. Disponível em: https://www.youtube.com/watch?v=2uXNNKLyP34. Acesso em: 19 de Out. 2022.