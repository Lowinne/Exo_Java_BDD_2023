<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion à MariaDB via JSP</title>
</head>
<body>
    <h1>Exemple de connexion à MariaDB avec JSP</h1>
    <% 
    String url = "jdbc:mariadb://localhost:3306/films";
    String user = "mysql";
    String password = "mysql";
    

        // Charger le pilote JDBC (pilote disponible dans WEB-INF/lib)
        Class.forName("org.mariadb.jdbc.Driver");

        // Établir la connexion
        Connection conn = DriverManager.getConnection(url, user, password);
        // Exemple de requête SQL
        String sql = "SELECT idFilm, titre, année FROM Film WHERE année >= 2000";
        String sql1 = "SELECT idFilm, titre, année FROM Film WHERE année > 2000 AND année < 2015";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        PreparedStatement pstmt1 = conn.prepareStatement(sql1);
        ResultSet rs = pstmt.executeQuery();
        ResultSet rs1 = pstmt1.executeQuery();

        // Afficher les résultats (à adapter selon vos besoins)
        while (rs.next()) {
            String colonne1 = rs.getString("idFilm");
            String colonne2 = rs.getString("titre");
            String colonne3 = rs.getString("année");
            // Faites ce que vous voulez avec les données...
            //Exemple d'affichage de 2 colonnes
            out.println("id : " + colonne1 + ", titre : " + colonne2 + ", année : " + colonne3 + "</br>");
        } %>
<h2>Exercice 1 : Les films entre 2000 et 2015</h2>
<p>Extraire les films dont l'année est supérieur à l'année 2000 et inférieur à 2015.</p>
<%

while (rs1.next()) {
            String colonne11 = rs1.getString("idFilm");
            String colonne21 = rs1.getString("titre");
            String colonne31 = rs1.getString("année");
            // Faites ce que vous voulez avec les données...
            //Exemple d'affichage de 2 colonnes
            out.println("id : " + colonne11 + ", titre : " + colonne21 + ", année : " + colonne31 + "</br>");
        } 

        // Fermer les ressources 
        rs.close();
        pstmt.close();
        rs1.close();
        pstmt1.close();
        conn.close();

    %>



<h2>Exercice 2 : Année de recherche</h2>
<p>Créer un champ de saisie permettant à l'utilisateur de choisir l'année de sa recherche.</p>

<form action="" method="post">
    <label for="searchYear">Année de recherche:</label>
    <input type="text" id="searchYear" name="searchYear">
    <input type="submit" value="Rechercher">
</form>

<%
    String searchYearParam = request.getParameter("searchYear");

    if (searchYearParam != null && !searchYearParam.isEmpty()) {
        int searchYear = Integer.parseInt(searchYearParam);

        String sqlSearch = "SELECT idFilm, titre, année FROM Film WHERE année = ?";
        PreparedStatement pstmtSearch = conn.prepareStatement(sqlSearch);
        pstmtSearch.setInt(1, searchYear);

        ResultSet rsSearch = pstmtSearch.executeQuery();

        while (rsSearch.next()) {
            String col1 = rsSearch.getString("idFilm");
            String col2 = rsSearch.getString("titre");
            String col3 = rsSearch.getString("année");

            out.println("id : " + col1 + ", titre : " + col2 + ", année : " + col3 + "</br>");
        }

        rsSearch.close();
        pstmtSearch.close();
    }
%>

<h2>Exercice 3 : Modification du titre du film</h2>
<p>Créer un fichier permettant de modifier le titre d'un film sur la base de son ID (ID choisi par l'utilisateur)</p>

<form action="" method="post">
    <label for="filmId">ID du film:</label>
    <input type="text" id="filmId" name="filmId">
    <label for="newTitle">Nouveau titre:</label>
    <input type="text" id="newTitle" name="newTitle">
    <input type="submit" value="Modifier Titre">
</form>

<%
    String filmIdParam = request.getParameter("filmId");
    String newTitleParam = request.getParameter("newTitle");

    if (filmIdParam != null && newTitleParam != null && !filmIdParam.isEmpty() && !newTitleParam.isEmpty()) {
        int filmId = Integer.parseInt(filmIdParam);

        String sqlUpdate = "UPDATE Film SET titre = ? WHERE idFilm = ?";
        PreparedStatement pstmtUpdate = conn.prepareStatement(sqlUpdate);
        pstmtUpdate.setString(1, newTitleParam);
        pstmtUpdate.setInt(2, filmId);

        int rowsUpdated = pstmtUpdate.executeUpdate();

        if (rowsUpdated > 0) {
            out.println("Le titre du film a été modifié avec succès.");
        } else {
            out.println("Erreur lors de la modification du titre du film.");
        }

        pstmtUpdate.close();
    }
%>

<h2>Exercice 4 : La valeur maximum</h2>
<p>Créer un formulaire pour saisir un nouveau film dans la base de données</p>

<form action="" method="post">
    <label for="newFilmTitle">Titre du nouveau film:</label>
    <input type="text" id="newFilmTitle" name="newFilmTitle">
    <label for="newFilmYear">Année du nouveau film:</label>
    <input type="text" id="newFilmYear" name="newFilmYear">
    <input type="submit" value="Ajouter Nouveau Film">
</form>

<%
    String newFilmTitleParam = request.getParameter("newFilmTitle");
    String newFilmYearParam = request.getParameter("newFilmYear");

    if (newFilmTitleParam != null && newFilmYearParam != null && !newFilmTitleParam.isEmpty() && !newFilmYearParam.isEmpty()) {
        String sqlInsert = "INSERT INTO Film (titre, année) VALUES (?, ?)";
        PreparedStatement pstmtInsert = conn.prepareStatement(sqlInsert);
        pstmtInsert.setString(1, newFilmTitleParam);
        pstmtInsert.setInt(2, Integer.parseInt(newFilmYearParam));

        int rowsInserted = pstmtInsert.executeUpdate();

        if (rowsInserted > 0) {
            out.println("Le nouveau film a été ajouté avec succès.");
        } else {
            out.println("Erreur lors de l'ajout du nouveau film.");
        }

        pstmtInsert.close();
    }
%>

</body>
</html>
