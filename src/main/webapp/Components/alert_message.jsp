<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 8:45 PM
--%>
<%@page import="lk.ecommerce.ecommerce1.entities.Message" %>
<%
    // Ensure that the session object is properly accessed and terminated:
    Message messg = (Message) session.getAttribute("message");
    if (messg != null) {
%>
<div class="alert <%=messg.getCssClass()%>" role="alert" id="alert">
    <%=messg.getMessage()%> <!-- Ensure no trailing characters here -->
</div>
<%
    // Remove the session attribute to avoid repeated display:
    session.removeAttribute("message");
%>
<script type="text/javascript">
    setTimeout(function() {
        $('#alert').alert('close');
    }, 3000);
</script>
<%
    }
%> <!-- Properly terminate scriptlet block -->