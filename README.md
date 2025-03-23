
# APACHE CASSANDRA BBDD

### 1r ASIX  
**Ievgen Soloviov**  
**Ayoub El Khalifi Idrissi El Jerari**

---

## DESCRIPCIÓ BASE DE DADES ESCOLLIDA

### Història i suport
Apache Cassandra es va desenvolupar originalment a **Facebook** el 2008 per a gestionar la cerca en la seva funcionalitat de missatgeria. Posteriorment, va ser alliberat com a codi obert i donat a la comunitat Apache, passant a formar part de l'**Apache Software Foundation (ASF)** el 2010. Actualment, Cassandra és mantingut i desenvolupat per una comunitat activa de col·laboradors, amb el suport de grans empreses com **DataStax**, **Amazon**, i altres organitzacions tecnològiques.

---

### Casos d'ús recomanats
Cassandra és una base de dades distribuïda, escalable i sense un únic punt de fallada. Està dissenyada per gestionar grans volums de dades en entorns que requereixen alta disponibilitat i tolerància a fallades. Alguns casos d'ús típics són:

- **Serveis de xarxes socials**: Facebook, Twitter, Instagram.
- **IoT i telemetria**: Recollida i anàlisi de dades de sensors.
- **E-commerce i recomanacions**: Amazon, eBay.
- **Anàlisi de grans volums de dades**: Telecomunicacions.

---

### Versions disponibles

- **Community Edition**: Versió gratuïta i de codi obert mantinguda per Apache.
- **DataStax Enterprise (DSE)**: Versió comercial amb millores de seguretat i rendiment.
- **Serveis Cloud**: Amazon Keyspaces, Microsoft Azure Managed Cassandra, Google Cloud Bigtable.

---

## COMPARACIÓ AMB ALTRES BASES DE DADES

| Característica                | Apache Cassandra       | MongoDB             | Amazon DynamoDB     | HBase                |
|------------------------------|------------------------|---------------------|---------------------|----------------------|
| Model de dades               | Clau-valor i columnes  | Documents JSON      | Clau-valor          | Columnar             |
| Escalabilitat                | Alta (distribuïda)     | Alta (distribuïda)  | Alta (AWS)          | Alta (Hadoop)        |
| Tolerància a fallades        | Sí, sense SPoF         | Sí, replica         | Sí, alta disponibilitat | Sí, replicació     |
| Rendiment                    | Alt per escriptures    | Alt per lectures    | Molt ràpid          | Bo per Big Data      |
| Casos d’ús ideals            | Big Data, IoT, socials | Web i mòbil         | Serverless i Cloud  | Hadoop/Big Data      |
| Consistència                 | Eventual/Forta         | Eventual/Forta      | Eventual            | Forta (Zookeeper)    |
| Transaccions ACID            | No                     | Parcial             | No                  | No                   |

---

## INSTAL·LACIÓ I CONFIGURACIÓ EN DOCKER (DEBIAN)

### 1. Execució de Cassandra amb Docker

Descarrega la imatge de **DataStax Studio** (entorn gràfic):
```bash
docker pull datastax/dse-studio:latest
```

Descarrega i executa Cassandra:
```bash
docker run --name cassandra -d -p 9042:9042 -p 7000:7000 cassandra:latest
```

Accedeix a CQLSH:
```bash
docker exec -it cassandra cqlsh
```

---

### 2. Configuració bàsica

Crear un contenidor amb volum:
```bash
docker run --name cassandra -d \
  -v cassandra_data:/var/lib/cassandra \
  -p 9042:9042 -p 7000:7000 cassandra:latest
```

Editar configuració:
```bash
docker exec -it cassandra bash
nano /etc/cassandra/cassandra.yaml
```

---

### 3. Configuració del firewall (si està actiu)

```bash
sudo ufw allow 7000/tcp
sudo ufw allow 9042/tcp
sudo ufw reload
```

---

### 4. Verificació

```bash
docker exec -it cassandra cqlsh localhost 9042
```

---

## SECURITZACIÓ I OPERACIONS

### Securització del sistema

Activar autenticació en `cassandra.yaml`:
```yaml
authenticator: PasswordAuthenticator
authorizer: CassandraAuthorizer
```

Crear usuari administrador via CQL:
```sql
CREATE ROLE admin WITH PASSWORD = 'admin123' AND LOGIN = true AND SUPERUSER = true;
```

---

### Gestió del servei (Docker)

**Arrencar Cassandra:**
```bash
docker start cassandra
```

**Verificar estat:**
```bash
docker ps -a
docker logs cassandra
```

**Aturar Cassandra:**
```bash
docker stop cassandra
```

---

### Fitxer de configuració

- **Ruta dins del contenidor:**  
  `/etc/cassandra/cassandra.yaml`

---

### Ubicació de dades

- **Per defecte:**  
  `/var/lib/cassandra/data`

Verificació:
```bash
docker exec -it cassandra ls /var/lib/cassandra/data
```

---

### Ports per defecte

| Port | Funció                        |
|------|-------------------------------|
| 7000 | Comunicació entre nodes       |
| 7001 | Comunicació segura SSL        |
| 9042 | Connexions CQL (clients)      |
| 7199 | JMX per monitoratge           |

#### Per canviar ports:
Editar `cassandra.yaml` i modificar:
```yaml
native_transport_port: 9042
storage_port: 7000
ssl_storage_port: 7001
```
Reiniciar el contenidor.

---

## CONNEXIÓ A CASSANDRA

### Via terminal

```bash
docker exec -it cassandra cqlsh
```

### Via DataStax Studio

Si has instal·lat `datastax/dse-studio`, obre:

```
http://localhost:9091
```

### Des de Python (amb driver)

```python
from cassandra.cluster import Cluster
cluster = Cluster(['localhost'])
session = cluster.connect()
session.execute("SELECT release_version FROM system.local")
```

Aquesta demostració valida que Cassandra accepta connexions.

---

## REFERÈNCIES

- https://cassandra.apache.org  
- https://hub.docker.com/_/cassandra  
- https://docs.docker.com/engine/install/debian
