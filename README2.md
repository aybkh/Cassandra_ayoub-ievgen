# DESCRIPCIÓ BASE DE DADES ESCOLLIDA: Apache Cassandra


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
| **Model de dades** | Clau-valor i columnes | Clau-valor | Columnar |
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
Accedeix a la línia de comandes de Cassandra (CQLSH):

```
docker exec -it cassandra cqlsh
```

Per llistar els Keyspaces que té Cassandra per defecte:

```sql
DESCRIBE KEYSPACES;
```

Crear un nou keyspace:

```sql
CREATE KEYSPACE <nom_keyspace> WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
```

Utilitzar un keyspace:

```sql
USE <nom_keyspace>;
```

Crear una taula:

```sql
CREATE TABLE <taula> (id UUID PRIMARY KEY, nom text);
```

Inserir dades:

```sql
INSERT INTO <taula> (id, nom) VALUES (uuid(), 'Nom de prova');
```

Llistar les dades:

```sql
SELECT * FROM <taula>;
```



### Configuració del Firewall

A la configuració del Firewall, s’ha d’obrir el port 9042 de connexió a Cassandra per a administració remota executant una comanda com aquesta:

```
iptables -A INPUT -p tcp --dport 9042 -j ACCEPT
```


### 2na Opció: Amb DataStax Enterprise (DSE) i Studio amb Docker (interfície gràfica)

Mitjançant aquest fitxer `docker-compose.yaml` aixequem els dos serveis que necessitem (DSE server i DataStax Studio).


### Connexió a la base de dades des de DataStax Studio

Des del navegador fem una petició a la IP del server mitjançant el port 9091. Un cop dins, es configura una connexió a la BBDD, indicant la IP del server i el port 9042.

Després d’establir la connexió amb la BBDD, es crea un nou notebook i se li assigna la connexió establerta anteriorment.

Ara l’entorn de CQL està preparat per rebre sentències.


## Securització i operacions de Cassandra/DataStax Enterprise

Activar l'autenticació amb usuari i contrasenya:

```
authenticator: PasswordAuthenticator
authorizer: CassandraAuthorizer
```

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
