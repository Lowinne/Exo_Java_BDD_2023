<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Les tableaux</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les tableaux</h1>
<form action="#" method="post">
    <p>Saisir au minimu 3 chiffres à la suite, exemple : 6 78 15 <input type="text" id="inputValeur" name="chaine">
    <p><input type="submit" value="Afficher">
</form>
<%-- Récupération des valeurs --%>
    <% String chaine = request.getParameter("chaine"); %>
    
    <% if (chaine != null) { %>

    <%-- Division de la chaîne de chiffres séparés par des espaces --%>
    <% String[] tableauDeChiffres = chaine.split("\\s+"); %>
    <p>La tableau contient <%= tableauDeChiffres.length %> valeurs</br>
    Chiffre 1 : <%= Integer.parseInt(tableauDeChiffres[0]) %></br>
    Chiffre 2 : <%= Integer.parseInt(tableauDeChiffres[1]) %></br>
    Chiffre 3 : <%= Integer.parseInt(tableauDeChiffres[2]) %></p>
    
<h2>Exercice 1 : La carré de la première valeur</h2>
<p>Ecrire un programme afin d'afficher le carré de la première valeur</p>
<% int c1 = Integer.parseInt(tableauDeChiffres[0]); %>
<% int carre = c1*c1; %>
<%= carre %>

<h2>Exercice 2 : La somme des 2 premières valeurs</h2>
<p>Ecrire un programme afin d'afficher la somme des deux premières valeurs</p>
<% int c2 = Integer.parseInt(tableauDeChiffres[1]); %>
<% int som = c1 + c2; %>
<%= som %>

<h2>Exercice 3 : La somme de toutes les valeurs</h2>
<p>L'utilisateur peut à présent saisir autant de valeurs qu'il le souhaite dans champs de saisie.</br>
Ecrire un programme afin de faire la somme de toutes les valeurs saisie par l'utilisateur</p>
<%int tot = 0; %>
<%int cpt = tableauDeChiffres.length; %>
<% for (int i = 0; i < cpt; i++) { %>
   <% tot = Integer.parseInt(tableauDeChiffres[i]) + tot; %>
<% } %>
<%= tot %>

<h2>Exercice 4 : La valeur maximum</h2>
<p>Ecrire un programme pour afficher la valeur maximale saisie par l'utilisateur</p>
<%int plus = 0; %>
<% for (int y = 0; y < cpt; y++) { %>
   <% if (plus < Integer.parseInt(tableauDeChiffres[y])) { %>
        <% plus = Integer.parseInt(tableauDeChiffres[y]); } %>
<% } %>
<%= plus %>

<h2>Exercice 5 : La valeur minimale</h2>
<p>Ecrire un programme pour afficher la valeur minimale saisie par l'utilisateur</p>
<%int moins = c1; %>
<% for (int z = 1; z < cpt; z++) { %>
   <% if (moins > Integer.parseInt(tableauDeChiffres[z])) { %>
        <% moins = Integer.parseInt(tableauDeChiffres[z]); } %>
<% } %>
<%= moins %>

<h2>Exercice 6 : La valeur le plus proche de 0</h2>
<p>Trouvez la valeur la plus proche de 0 (chiffres positifs ou négatifs)</p>

<h2>Exercice 7 : La valeur le plus proche de 0 (2° version)</h2>
<p>Trouvez la valeur la plus proche de 0 (chiffres positifs ou négatifs)</p>
<p>En cas d'égalité entre un chiffre positif et négatif, affichez le chiffre positif</p>
<%
    int[] tableauDeChiffres = {5, -3, 8, -1, 4, 2, -7, 0}; // Remplacez cela par votre tableau réel

    int chiffreProcheDeZero = 0;

    if (tableauDeChiffres.length > 0) {
        // Trier le tableau pour faciliter la recherche du chiffre le plus proche de zéro
        Arrays.sort(tableauDeChiffres);

        // Initialiser avec la première valeur
        chiffreProcheDeZero = tableauDeChiffres[0];

        for (int i = 1; i < tableauDeChiffres.length; i++) {
            int valeurActuelle = tableauDeChiffres[i];

            // Si la valeur absolue actuelle est plus petite que celle du chiffre actuel le plus proche de zéro
            // ou si les deux valeurs ont la même valeur absolue mais la valeur actuelle est positive
            if (Math.abs(valeurActuelle) < Math.abs(chiffreProcheDeZero) || 
                (Math.abs(valeurActuelle) == Math.abs(chiffreProcheDeZero) && valeurActuelle > 0)) {
                chiffreProcheDeZero = valeurActuelle;
            }
        }
    }
%>
<%=chiffreProcheDeZero %>

<% } %>
<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
