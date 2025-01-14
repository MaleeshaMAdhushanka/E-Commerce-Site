<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/14/2025
  Time: 3:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title> User Management</title>

<%--    Boot strap css--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">User Management</h1>

    <!-- User List Table -->
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h4>User List</h4>
        </div>
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${userList}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td>
                                <span class="badge ${user.status == 'Active' ? 'bg-success' : 'bg-danger'}">
                                        ${user.status}
                                </span>
                        </td>
                        <td>
                            <!-- Activate/Deactivate Form -->
                            <form method="post" action="UserManagementServlet" class="d-inline">
                                <input type="hidden" name="userId" value="${user.id}">
                                <button type="submit" name="action" value="activate" class="btn btn-success btn-sm" ${user.status == 'Active' ? 'disabled' : ''}>Activate</button>
                                <button type="submit" name="action" value="deactivate" class="btn btn-danger btn-sm" ${user.status == 'Inactive' ? 'disabled' : ''}>Deactivate</button>
                            </form>
                            <!-- Update User Button -->
                            <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#updateUserModal" onclick="setUpdateModal('${user.id}', '${user.name}', '${user.email}')">Update</button>
                            <!-- Delete User Form -->
                            <form method="post" action="UserManagementServlet" class="d-inline">
                                <input type="hidden" name="userId" value="${user.id}">
                                <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Add User Form -->
    <div class="card mt-4">
        <div class="card-header bg-secondary text-white">
            <h4>Add New User</h4>
        </div>
        <div class="card-body">
            <form method="post" action="UserManagementServlet">
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter user name" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter user email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                </div>
                <button type="submit" name="action" value="add" class="btn btn-primary">Add User</button>
            </form>
        </div>
    </div>

    <!-- Update User Modal -->
    <div class="modal fade" id="updateUserModal" tabindex="-1" aria-labelledby="updateUserModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateUserModalLabel">Update User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="post" action="UserManagementServlet">
                    <div class="modal-body">
                        <input type="hidden" id="updateUserId" name="userId">
                        <div class="mb-3">
                            <label for="updateName" class="form-label">Name</label>
                            <input type="text" class="form-control" id="updateName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="updateEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="updateEmail" name="email" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" name="action" value="update" class="btn btn-warning">Update</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Populate Update Modal with user details
    function setUpdateModal(userId, name, email) {
        document.getElementById('updateUserId').value = userId;
        document.getElementById('updateName').value = name;
        document.getElementById('updateEmail').value = email;
    }
</script>

</body>
</html>
