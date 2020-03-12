

rm(list = ls())
pckgs <- c("tidyverse", "magrittr", "RNeo4j")
lapply(pckgs, library, character.only = TRUE)


# Connect to currently running Neo4j database at a specific URL

gdb <- startGraph("http://localhost:7474/db/data/",
                  username = "neo4j", password = "690515mk")

# Clear the current database. This will delete all the data, so by default
# input = TRUE which will prompt us to confirm

clear(gdb, input = FALSE)
object.size(gdb)

# Add a uniqueness constraint for "Person" nodes (persons are going to be uniquely
# identified by the property "name")

addConstraint(gdb, "Person", "name")

# Create "Person" nodes

aiden <- createNode(gdb, "Person", name="Aiden", age=20)
greta <- createNode(gdb, "Person", name="Greta", age=30)
annie <- createNode(gdb, "Person", name="Annie", age=40)
andre <- createNode(gdb, "Person", name="Andre", age=50)

gdb <- startGraph("http://localhost:7474/db/data/",
                  username = "neo4j", password = "690515mk")

object.size(gdb)


query <- "
MATCH (p:Person)
RETURN p.name AS Name, p.age AS Age
"
x <- cypher(gdb, query) %>% as_tibble
print(x)


