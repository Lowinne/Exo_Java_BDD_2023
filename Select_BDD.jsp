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



<%
// Function to establish a database connection
public Connection connectToDatabase() throws ClassNotFoundException, SQLException {
    String url = "jdbc:mariadb://localhost:3306/films";
    String user = "mysql";
    String password = "mysql";
    
    Class.forName("org.mariadb.jdbc.Driver");
    return DriverManager.getConnection(url, user, password);
}

// Function to close database resources
public void closeResources(Connection conn, PreparedStatement pstmt, ResultSet rs) throws SQLException {
    if (rs != null) rs.close();
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
}

// Exercise 1: Display films between 2000 and 2015
public void displayFilmsBetween2000And2015() throws SQLException, ClassNotFoundException {
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = connectToDatabase();
        String sql = "SELECT idFilm, titre, année FROM Film WHERE année > 2000 AND année < 2015";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            out.println("id: " + rs.getString("idFilm") + ", titre: " + rs.getString("titre") +
                    ", année: " + rs.getString("année") + "</br>");
        }
    } finally {
        closeResources(conn, pstmt, rs);
    }
}

// Exercise 2: Display films based on user-selected year
public void displayFilmsByYear(int selectedYear) throws SQLException, ClassNotFoundException {
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = connectToDatabase();
        String sql = "SELECT idFilm, titre, année FROM Film WHERE année = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, selectedYear);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            out.println("id: " + rs.getString("idFilm") + ", titre: " + rs.getString("titre") +
                    ", année: " + rs.getString("année") + "</br>");
        }
    } finally {
        closeResources(conn, pstmt, rs);
    }
}

// Exercise 3: Modify film title by ID
public void modifyFilmTitleById(int filmId, String newTitle) throws SQLException, ClassNotFoundException {
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = connectToDatabase();
        String sql = "UPDATE Film SET titre = ? WHERE idFilm = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, newTitle);
        pstmt.setInt(2, filmId);
        pstmt.executeUpdate();
        out.println("Film title updated successfully.");
    } finally {
        closeResources(conn, pstmt, null); // No ResultSet for update operation
    }
}

// Exercise 4: Insert a new film into the database
public void insertNewFilm(String title, int year) throws SQLException, ClassNotFoundException {
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = connectToDatabase();
        String sql = "INSERT INTO Film (titre, année) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setInt(2, year);
        pstmt.executeUpdate();
        out.println("New film inserted successfully.");
    } finally {
        closeResources(conn, pstmt, null); // No ResultSet for insert operation
    }
}

%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion à MariaDB via JSP</title>
</head>
<body>
    <h1>Exemple de connexion à MariaDB avec JSP</h1>

    <% displayFilmsBetween2000And2015(); %>

    <h2>Exercice 2 : Année de recherche</h2>
    <p>Extraire les films pour une année spécifique :</p>
    <form method="post">
        <label for="year">Année de recherche :</label>
        <input type="text" name="year" id="year">
        <input type="submit" value="Rechercher">
    </form>
    <% 
        String selectedYearParam = request.getParameter("year");
        if (selectedYearParam != null && !selectedYearParam.isEmpty()) {
            int selectedYear = Integer.parseInt(selectedYearParam);
            displayFilmsByYear(selectedYear);
        }
    %>

    <h2>Exercice 3 : Modification du titre du film</h2>
    <p>Modifier le titre d'un film :</p>
    <form method="post">
        <label for="filmId">ID du film :</label>
        <input type="text" name="filmId" id="filmId">
        <label for="newTitle">Nouveau titre :</label>
        <input type="text" name="newTitle" id="newTitle">
        <input type="submit" value="Modifier">
    </form>
    <% 
        String filmIdParam = request.getParameter("filmId");
        String newTitleParam = request.getParameter("newTitle");
        if (filmIdParam != null && newTitleParam != null && !filmIdParam.isEmpty() && !newTitleParam.isEmpty()) {
            int filmId = Integer.parseInt(filmIdParam);
            modifyFilmTitleById(filmId, newTitleParam);
        }
    %>

    <h2>Exercice 4 : La valeur maximum</h2>
    <p>Créer un formulaire pour saisir un nouveau film dans la base de données :</p>
    <form method="post">
        <label for="newFilmTitle">Titre du film :</label>
        <input type="text" name="newFilmTitle" id="newFilmTitle">
        <label for="newFilmYear">Année du film :</label>
        <input type="text" name="newFilmYear" id="newFilmYear">
        <input type="submit" value="Ajouter">
    </form>
    <% 
        String newFilmTitleParam = request.getParameter("newFilmTitle");
        String newFilmYearParam = request.getParameter("newFilmYear");
        if (newFilmTitleParam != null && newFilmYearParam != null &&
            !newFilmTitleParam.isEmpty() && !newFilmYearParam.isEmpty()) {
            int newFilmYear = Integer.parseInt(newFilmYearParam);
            insertNewFilm(newFilmTitleParam, newFilmYear);
        }
    %>

</body>
</html>
