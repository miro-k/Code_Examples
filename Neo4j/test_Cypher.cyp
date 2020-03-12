// :help cypher

// Examples of queries on the movie database =============================================

// Get names of all persons who wrote a movie and the corresponding movie titles

MATCH (p)-[:WROTE]->(m) RETURN p.name, m.title;

// Get names of all persons who wrote and produced a movie at the same time

MATCH (p)-[:WROTE]->(m), (p)-[:PRODUCED]->(m) RETURN p.name, m.title;

// Get names of all persons associated with the movice "V for Vendetta" and the type
// of relationship they have to the movie

MATCH (p:Person)-[r]->(m:Movie) RETURN p.name, type(r), m.title;

// Get names of the directors and writers of each movie along with the movie title
// and year it was released. Also, give specific names to the pieces of information
// retrieved (using AS)

MATCH (pd:Person)-[:DIRECTED]->(m:Movie)<-[:WROTE]-(pw:Person)
   RETURN pd.name AS Director, pw.name AS Writer, m.title AS Title, m.released AS Year;

// Execute the same query as above but this time specify that it is only for
// the movies "V for Vendetta" or "Cloud Atlas"

MATCH (pd:Person)-[:DIRECTED]->(m:Movie)<-[:WROTE]-(pw:Person)
   WHERE m.title = "V for Vendetta" OR m.title = "Cloud Atlas"
   RETURN pd.name AS Director, pw.name AS Writer, m.title AS Title, m.released AS Year;


// SECTION (5) ---------------------------------------------------------------------------

// Get the titles of the movies directed by Tom Hanks

MATCH (d:Person)-[:DIRECTED]->(m:Movie)
   WHERE d.name = "Tom Hanks"
   RETURN m.title;

MATCH (d:Person {name: "Tom Hanks"})-[:DIRECTED]->(m:Movie)
   RETURN m.title;

// Get the names of the directors and titles of the movies Tom Hanks acted in

MATCH (a:Person {name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie)<-[:DIRECTED]-(d)
   RETURN m.title, d.name, m.released
   ORDER BY m.released;

// Get the title(s) of the movies in which Tom Hanks acted in and which were directed
// by Lana Wachowski

MATCH (a:Person {name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie)<-[:DIRECTED]-(d:Person {name:"Lana Wachowski"})
   RETURN m.title, d.name, a.name

MATCH (a:Person)-[:ACTED_IN]->(m:Movie)<-[:DIRECTED]-(d:Person)
   WHERE a.name =  "Tom Hanks" AND d.name = "Lana Wachowski"
   RETURN m.title, d.name, a.name

// Find the titles of the movies and the names of the directors of the movies starring Tom Hanks

// Note that the following query produces some duplicates in the directors' names (one director directed
// 2 or more movies in which Tom Hanks acted)

MATCH (a:Person {name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie)<-[:DIRECTED]-(d)
   RETURN d.name, m.title
   ORDER BY d.name;

// If we only care for the directors' names, we might want to eliminate the duplicates via DISTINCT

MATCH (a:Person {name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie)<-[:DIRECTED]-(d)
   RETURN DISTINCT d.name
   ORDER BY d.name;

// Create label-specific index !!! Don't know what an index is good for

CREATE INDEX ON :Person(name)

// Handle conditions on properties

// Get movie titles that Tom Hanks acted in and that were released before 1992

MATCH (a:Person {name:"Tom Hanks"})-[:ACTED_IN]->(m:Movie)
   WHERE m.released < 1992
   RETURN DISTINCT m.title;

// Get the movie title that Keanu Reeves had a role of "Neo". So we're imposing a condition
// on a property ("roles") of a relationship (between an actor and a movie)
MATCH (a:Person {name: "Keanu Reeves"})-[r:ACTED_IN]->(m:Movie)
   WHERE "Neo" IN (r.roles)
   RETURN DISTINCT m.title;

// The same as above but differently

MATCH (a:Person {name: "Keanu Reeves"})-[r:ACTED_IN]->(m:Movie)
   WHERE ANY( x IN r.roles WHERE x = "Neo")
   RETURN DISTINCT m.title;
   
// Conditions based on comparison: Find actors who were in the same movie(s) as
// Tom Hanks but are older than him

MATCH (tom:Person {name:"Tom Hanks"})-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(a:Person)
   WHERE a.born < tom.born
   RETURN DISTINCT a.name, a.born, tom.born, m.title;

   
// Handling conditions on patterns ...

// Find actors who were in the same movie(s) "m" as Gene Hackman

MATCH (gene:Person {name:"Gene Hackman"})-[:ACTED_IN]->(m)<-[:ACTED_IN]-(actor)
   RETURN DISTINCT actor.name;
   
// Repeat the above, but select only the actors who were also directors of their movies "m"

MATCH (gene:Person {name:"Gene Hackman"})-[:ACTED_IN]->
   (m)<-[:ACTED_IN]->(actor_director)
   WHERE (actor_director)-[:DIRECTED]->()
   RETURN DISTINCT actor_director.name;

// Another way of doing the same as above (my own concoction). This time I also want to
// pull out the titles of the movie(s) "m". Note, we could restrict the part of the pattern
// that defines the director to point to a node of type "Movie": ...-[:DIRECTED]->(Movie)
   
MATCH (gene:Person {name:"Gene Hackman"})-[:ACTED_IN]->
   (m:Movie)<-[:ACTED_IN]->(actor_director)-[:DIRECTED]->()
   RETURN DISTINCT actor_director.name, m.title;

// Find actors who were in the same movie(s) "m" as Keanu Reeves, but not when he was also
// working with Hugo Weaving.

MATCH (keanu:Person {name:"Keanu Reeves"})-[:ACTED_IN]->(m)<-[:ACTED_IN]-(actor),
   (hugo:Person {name:"Hugo Weaving"})
   WHERE NOT (hugo)-[:ACTED_IN]->(m)
   RETURN DISTINCT actor.name, m.title;

// Challenge: Who are the 5 busiest actor? How busy an actor is is measured by the number
// of movies he/she appeared in.

MATCH (actor:Person)-[:ACTED_IN]->(m:Movie)
   RETURN actor.name AS Name, count(m) AS Count
   ORDER BY Count DESC
   LIMIT 5;
   
// Note that we don't have to specify "m:Movie" as there is nothing else a Person could
// possibly "ACTED_IN". That is, we can simplify the above query to

MATCH (actor:Person)-[:ACTED_IN]->()
   RETURN actor.name, count(*) AS Count
   ORDER BY Count DESC
   LIMIT 5;

// Challenge: Recommend 3 actors that Keanu Reeves should work with (but hasn't). That is,
// look for people who acted in movies with Keanu Reeves, and then find people these
// actors acted with in other movies (in which Keanu Reeves didn't act).
 
 
 
/////////////// THIS IS NOT WORKING 
MATCH (keanu:Person {name:"Keanu Reeves"}),
      (keanu)-[:ACTED_IN]->(m_1)<-[:ACTED_IN]-(actor_1),
      (actor_1)-[:ACTED_IN]->(m_2)<-[:ACTED_IN]-(actor_2)
   WHERE NOT actor_2.name = "Keanu Reeves"
   RETURN DISTINCT actor_1.name, collect(actor_2.name)
   ORDER BY count(m_2.title) DESC
   LIMIT 10;

   
   
   
   
   
// Solution by the course teacher:

MATCH (keanu:Person)-[:ACTED_IN]->()<-[:ACTED_IN]-(c),
      (c)-[:ACTED_IN]->()<-[:ACTED_IN]-(coc)
   WHERE keanu.name = "Keanu Reeves"
   AND NOT ((keanu)-[:ACTED_IN]->()<-[:ACTED_IN]-(coc))
   AND coc <> keanu
   RETURN coc.name, count(coc)
   ORDER BY count(coc) DESC
   LIMIT 10;
   
   
// SECTION (6) ---------------------------------------------------------------------------
// Done at work

MATCH (kevin:Person {name:"Kevin Bacon"})-[:ACTED_IN]->(movie)
RETURN DISTINCT movie.title

// Add a new node to the database: Kevin Bacon acted in "Mystic River" but the movie is
// not yet in the database, so we have to create it.

CREATE (m:Movie {title:"Mystic River", released: 1993})

// Test if the movie (node) was created

MATCH (m:Movie {title:"Mystic River"}) RETURN m;

MATCH (m:Movie)
RETURN m.title
ORDER BY m.title;

// Add a new property to an existing node: Add a "tagline" to the "Mystic River" movie
// First we have to find the movie using MATCH, then use SET to create a new property 
// and then use RETURN to check how it all went.

MATCH (m:Movie {title: "Mystic River"})
SET m.tagline = "We bury our sins here, Dave"
RETURN m;

// Note: it's possible to use SET to add a property to a set of nodes. For example,
// we could add a property "rating" to all movies in the database.

// Add a relationship to nodes: Link Kevin Bacon to "Mystic River" using the ACTED_IN
// relationship, and then add a property (Bacon's role in the movie) to the relatioship

MATCH (m:Movie {title: "Mystic River"}), (kevin:Person {name:"Kevin Bacon"})
MERGE (kevin)-[r:ACTED_IN]->(m)
ON CREATE SET r.roles = ["Sean"]

// Check who acted in "Mystic River", Kevin Bacon has to be in the list (indeed the
// only one as we have just created the "Mystic River" node). We'll also check the
// properties of the relationship:

MATCH (a:Person)-[r:ACTED_IN]->(m:Movie {title:"Mystic River"})
RETURN a.name, r.roles

// Challenge:

// 1) Insert a new movie titled "Cannonball Run" with "released" year 1984

CREATE (m:Movie {title:"Cannonball Run", released: 1984})
MATCH (m:Movie {title:"Cannonball Run"}) RETURN m;

// 2) Change Kevin Bacon's role in Mystic River from "Sean" to "Sean Divine"

MATCH (a:Person {name:"Kevin Bacon"})-[r:ACTED_IN]->(m:Movie {title: "Mystic River"})
SET r.roles = ["Sean Divine"]
RETURN r.roles

// Potential problem: Sometimes an actor has more than one role in the same movie. If
// that was the case here, we would have overwritten all the roles with the new
// "Sean Divine" one. A better way to do the challenge (2) is

MATCH (a:Person {name:"Kevin Bacon"})-[r:ACTED_IN]->(m:Movie {title: "Mystic River"})
SET r.roles = [n in r.roles WHERE n <> "Sean"] + "Sean Devine"
RETURN r.roles

// 3) Add Clint Eastwood as the director of "Mystic River" (i.e., create a new relationship)

MATCH (m:Movie {title: "Mystic River"}), (d:Person {name:"Clint Eastwood"})
MERGE (d)-[r:DIRECTED]->(m)

// See if it worked

MERGE (d:Person)-[:DIRECTED]->(m:Movie {title:"Mystic River"})
RETURN d.name


// SECTION (7) ---------------------------------------------------------------------------

// List all the roles in the movie "The Matrix"

MATCH (a:Person)-[r:ACTED_IN]->(m:Movie {title:"The Matrix"}) RETURN r.roles
// or simplified to
MATCH ()-[r:ACTED_IN]->(m:Movie {title:"The Matrix"}) RETURN r.roles

// There is a  role "Emil". What is it?
MATCH (a:Person)-[r:ACTED_IN]->(m:Movie {title:"The Matrix"})
   WHERE r.roles <> "Emil"
   RETURN a.name,  r.roles

// In the course, the teacher does something different. I think it's wrong. We're
// not to be conditioning on a name of a Person (even though it turns out to also
// be Emil) but on the role name.

//MATCH (a)-[r:ACTED_IN]->(m:Movie {title:"The Matrix"})
//WHERE a.name =~ ".*Emil.*"
//RETURN a

// We identified Emil Eifrem as the role "Emil". There is no such role in the movie
// so we'll remove that person from the movie. Note: we first need to delete all(!) the
// relationships that the Person has ("r") and then the person himself ("a")

// Note that we use -[r]-() to define any relationships to any nodes (we don't
// specify the direction of the relatinship)

MATCH (a:Person {name:"Emil Eifrem"})-[r]-() DELETE r;
MATCH (a:Person {name:"Emil Eifrem"}) DELETE a;

// The above can be simplified into one statement

MATCH (a:Person {name:"Emil Eifrem"})
   OPTIONAL MATCH (a)-[r]-()
   DELETE r, a;

// Challenge: Add KNOWS relationships between all actors who were in the same movie

MATCH (a:Person)-[:ACTED_IN]->()<-[:ACTED_IN]-(b:Person)
   CREATE UNIQUE (a)-[:KNOWS]-(b)

// Using the MERGE and UNIQUE commands in Cypher

MATCH (p:Person {name:"Clint Eastwood"}) RETURN p

MERGE (p:Person {name:"Clint Eastwood"})
   ON CREATE SET p.created = timestamp()
   ON MATCH SET p.accessed = coalesce(p.accessed)+1
   RETURN p;

// Matching multiple relationships
// Add KNOWS relationship between all those who either acted in or directed the same
// moview

MATCH (a)-[:ACTED_IN|:DIRECTED]->()<-[:ACTED_IN|:DIRECTED]-(b)
   CREATE UNIQUE (a)-[:KNOWS]-(b)

// Exploring variable-length paths

// Example: Find friends of friends (max. 2 degrees of separations) of Keanu Reeves

MATCH (keanu:Person {name:"Keanu Reeves"})-[:KNOWS*2]-(fof)
   RETURN DISTINCT fof.name

MATCH (p:Person)-[:KNOWS*2]-(fof)
   WHERE p.name = "Keanu Reeves"
   RETURN DISTINCT fof.name
   
// Challenge: Find friends of friends of Keanu Reeves who are not immediate friends
// Note: "keanu <> fof" means "the person is not Keanu Reeves"
// "(keanu)-[:KNOWS]-(fof)" means "Keanu doesn't know the person directly"

MATCH (keanu:Person {name:"Keanu Reeves"})-[:KNOWS*2]-(fof)
   WHERE keanu <> fof AND NOT (keanu)-[:KNOWS]-(fof)
   RETURN DISTINCT fof.name

// Find shortest path between nodes (path is called "p", its length is returned)

MATCH p=shortestPath((a:Person)-[:KNOWS*]-(b:Person))
   WHERE a.name="Charlize Theron" AND b.name="Kevin Bacon"
   RETURN length(p)

// The following returns the same as the above
MATCH (a:Person {name:"Kevin Bacon"}),
      (b:Person {name:"Charlize Theron"}),
      p=shortestPath((a)-[:KNOWS*]-(b))
      RETURN length(p)

// Challenge: Return the names of the people joining Charlize to Kevin

MATCH p=shortestPath((a:Person)-[:KNOWS*]-(b:Person))
   WHERE a.name="Charlize Theron" AND b.name="Kevin Bacon"
   RETURN [n in nodes(p) | n.name]
