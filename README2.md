<h1 align="center">APACHE CASSANDRA</h1>

![Image](https://github.com/user-attachments/assets/bee4a18b-585d-4734-9905-410e3efaabf9)

---

## DESCRIPCIÓ BASE DE DADES ESCOLLIDA
## Història i suport

Apache Cassandra es va desenvolupar originalment a Facebook el 2008 per a gestionar la cerca en la seva funcionalitat de missatgeria. Posteriorment, va ser alliberat com a codi obert i donat a la comunitat Apache, passant a formar part de l'Apache Software Foundation (ASF) el 2010. Actualment, Cassandra és mantingut i desenvolupat per una comunitat activa de col·laboradors, amb el suport de grans empreses com DataStax, Amazon, i altres organitzacions tecnològiques.

## Casos d'ús recomanats

Cassandra és una base de dades distribuïda, escalable i sense un únic punt de fallada. Està dissenyada per gestionar grans volums de dades en entorns que requereixen alta disponibilitat i tolerància a fallades. Alguns casos d'ús típics són:

- **Serveis de xarxes socials**: Facebook, Twitter i Instagram utilitzen bases de dades distribuïdes per gestionar milions de transaccions per segon.
- **IoT i telemetria**: Per recollir i analitzar dades de sensors en temps real.
- **E-commerce**: Amazon i eBay utilitzen sistemes com Cassandra per gestionar la informació de clients i recomanacions de productes.
- **Anàlisi de grans volums de dades**: Empreses de telecomunicacions utilitzen Cassandra per gestionar registres de trucades i monitoratge de xarxes.

## Versions disponibles

Cassandra disposa de diverses edicions que s'adapten a diferents necessitats:

- **Community Edition**: Versió gratuïta i de codi obert mantinguda per Apache.
- **DataStax Enterprise (DSE)**: Versió comercial desenvolupada per DataStax, amb millores en seguretat, suport i optimitzacions per a empreses.
- **Serveis Cloud**: Proveïdors com Amazon Keyspaces, Microsoft Azure Managed Cassandra i Google Cloud Bigtable ofereixen Cassandra com a servei gestionat al núvol.


## Comparatiu amb altres bases de dades

| Característica | Apache Cassandra | Amazon DynamoDB | HBase |
|--------------|----------------|----------------|------|
| **Model de dades** | columnes | Clau-valor | Columnar |
| **Escalabilitat** | Alta (distribuïda) | Alta (gestionada per AWS) | Alta (Hadoop) |
| **Tolerància a fallades** | Sí, sense SPoF | Sí, alta disponibilitat | Sí, replicació distribuïda |
| **Rendiment** | Alt per escriptures | Alta velocitat per consultes simples | Bo per Big Data |
| **Casos d’ús ideals** | Big Data, IoT, xarxes socials | Aplicacions serverless i cloud | Big Data en Hadoop |
| **Consistència** | Eventual (opcionalment forta) | Eventual per defecte | Forta (Zookeeper) |
| **Suport per transaccions ACID** | No | No | No |


## LA INSTAL·LACIÓ PAS A PAS

### Instal·lació i configuració del SGBD Apache Cassandra

#### 1ra Opció: Execució de Cassandra amb Docker sense interfície gràfica (Community Edition)

Descarrega i executa Cassandra:

```
docker run --name cassandra -d -p 9042:9042 -p 7000:7000 cassandra:latest
```
![Image](https://github.com/user-attachments/assets/5f699806-5699-4caa-90f5-8ce451e62a10)

Accedeix a la línia de comandes de Cassandra (CQLSH):

```
docker exec -it cassandra cqlsh
```

Per llistar els Keyspaces que té Cassandra per defecte:

```sql
DESCRIBE KEYSPACES;
```
![Image](https://github.com/user-attachments/assets/df0d6ca9-0534-4293-965f-2cc109358392)

Crear un nou keyspace:

```sql
CREATE KEYSPACE <nom_keyspace> WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
```
![Image](https://github.com/user-attachments/assets/220b4fbc-0ae4-41b1-a857-231327f22741)

Utilitzar un keyspace:

```sql
USE <nom_keyspace>;
```
Crear una taula:

```sql
CREATE TABLE <taula> (id UUID PRIMARY KEY, nom text);
```
![Image](https://github.com/user-attachments/assets/529c4fc5-798a-4bf9-bf48-5cc1f942a4d3)

Inserir dades:

```sql
INSERT INTO <taula> (id, nom) VALUES (uuid(), 'Nom');
```
Llistar les dades:

```sql
SELECT * FROM <taula>;
```
![Image](https://github.com/user-attachments/assets/19b3f62b-ede6-4078-9c9a-9fb95ae86c1f)


### Configuració del Firewall

A la configuració del Firewall, s’ha d’obrir el port 9042 de connexió a Cassandra per a administració remota executant una comanda com aquesta:

```
iptables -A INPUT -p tcp --dport 9042 -j ACCEPT
```


### 2na Opció: Amb DataStax Enterprise (DSE) i Studio amb Docker (interfície gràfica)

Mitjançant aquest fitxer `docker-compose.yaml` aixequem els dos serveis que necessitem (DSE server i DataStax Studio).
![Image](https://github.com/user-attachments/assets/574b7629-cc5b-47b8-bdb0-aa78b0d9071d)
![Image](https://github.com/user-attachments/assets/340bcba7-737b-4183-8b08-d91f61e2e1d8)

### Connexió a la base de dades des de DataStax Studio
![Image](https://github.com/user-attachments/assets/066f4138-43f6-465c-a0e6-c6c22b1ca68e)

Des del navegador fem una petició a la IP del server mitjançant el port 9091. Un cop dins, es configura una connexió a la BBDD, indicant la IP del server i el port 9042.
![Image](https://github.com/user-attachments/assets/17a58f40-505a-499f-bd2e-e20308e0b045)

Després d’establir la connexió amb la BBDD, es crea un nou notebook i se li assigna la connexió establerta anteriorment.
![Image](https://github.com/user-attachments/assets/5a809013-9b61-4050-af05-13daf3acc7d9)

Ara l’entorn de CQL està preparat per rebre sentències.
![Image](https://github.com/user-attachments/assets/e743faa0-820a-477e-8799-a4e62003b464)
![Image](https://github.com/user-attachments/assets/12e99206-eca5-4717-9e75-b4ea5f13703c)

## Securització i operacions de Cassandra/DataStax Enterprise

Activar l'autenticació amb usuari i contrasenya:

```
authenticator: PasswordAuthenticator
authorizer: CassandraAuthorizer
```
![Image](https://github.com/user-attachments/assets/f2cb84f6-47a3-4b6e-bea0-ccb57a930c22)
Un cop activada, s'ha de reiniciar el contenidor i crear usuaris amb permisos controlats mitjançant CQL:

```
CREATE ROLE admin WITH PASSWORD = 'P@ssw0rd' AND LOGIN = true AND SUPERUSER = true;
```


## Gestió de Cassandra

Arrencar Cassandra:

```
docker start cassandra
```

Verificar estat:

```
docker ps -a
```

Veure els logs:

```
docker logs cassandra
```

Aturar Cassandra:

```
docker stop cassandra
```


## Fitxers de configuració i dades

El fitxer de configuració de Cassandra es troba dins de la carpeta `etc` dins del contenidor:

```
/etc/cassandra/cassandra.yaml
```

Aquest fitxer defineix el comportament del node, ports, autenticació, ruta de dades, etc.

La ubicació de les dades per defecte dins del contenidor és:

```
/var/lib/cassandra/data
```

Aquesta ruta es pot verificar amb:

```
docker exec -it cassandra ls /var/lib/cassandra/data
```
![Image](https://github.com/user-attachments/assets/3e17671e-dc34-471e-ba95-c51c2a13a06f)

## Ports utilitzats per Cassandra

```
7000: comunicació entre nodes (no segura)
7001: comunicació segura entre nodes (SSL)
9042: connexions CQL (clients)
7199: JMX (monitoratge)
```

Ports utilitzats per DSE (Interfície gràfica):

```
7000: Comunicació entre nodes
7001: Comunicació entre nodes (SSL)
9042: Connexions CQL (clients)
7199: JMX per monitoratge
9091: DataStax Studio (interfície gràfica)
```
### EXTRA: Connexió des de Python (amb la llibreria cassandra-driver)

```python
from cassandra.cluster import Cluster

# Connexió a Cassandra
cluster = Cluster(contact_points=['192.168.224.3'], port=9042)
session = cluster.connect()

# Seleccionar el keyspace correcte
session.set_keyspace('ayoub_ievgen')

# Insertar dades
session.execute("""
INSERT INTO asix (id, nom, edat) VALUES (uuid(), 'Dani', 21);
""")

# Tancar la connexió
cluster.shutdown()

```
---

## REFERÈNCIES

- https://cassandra.apache.org
- https://hub.docker.com/_/cassandra
- https://docs.docker.com/engine/install/debian
- https://hub.docker.com/r/datastax/dse-server
- https://hub.docker.com/r/datastax/dse-studio
- https://chatgpt.com/
---

### 1r ASIX  
**Ievgen Soloviov**  
**Ayoub El Khalifi Idrissi El Jerari**
