<%@page import="DBOperation.KK"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DBOperation.DBOperation"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Page</title>
        <style>
            body {
                display: -webkit-box;
                display: flex;
                -webkit-box-pack: center;
                justify-content: center;
                -webkit-box-align: center;
                align-items: center;
                height: 100%;
                background: #fcf3ec;
            }

            .button {
                offset: 10px;
                border-size: 2px;
                display: block;
                position: relative;
                padding: 1.5em 3em;
                -webkit-appearance: none;
                -moz-appearance: none;
                appearance: none;
                border: 0;
                background: transparent;
                color: #e55743;
                text-transform: uppercase;
                letter-spacing: .25em;
                outline: none;
                cursor: pointer;
                font-weight: bold;
                border-radius: 0;
                box-shadow: inset 0 0 0 var(--border-size) currentcolor;
                -webkit-transition: background .8s ease;
                transition: background .8s ease;
                top: 12.5em;
                margin: 2em;
                width: 280px;
            }
            .button:hover {
                background: rgba(100, 0, 0, 0.03);
            }
            .button__horizontal, .button__vertical {
                position: absolute;
                top: var(--horizontal-offset, 0);
                right: var(--vertical-offset, 0);
                bottom: var(--horizontal-offset, 0);
                left: var(--vertical-offset, 0);
                -webkit-transition: -webkit-transform .8s ease;
                transition: -webkit-transform .8s ease;
                transition: transform .8s ease;
                transition: transform .8s ease, -webkit-transform .8s ease;
                will-change: transform;
            }
            .button__horizontal::before, .button__vertical::before {
                content: '';
                position: absolute;
                border: inherit;
            }
            .button__horizontal {
                --vertical-offset: calc(var(--offset) * -1);
                border-top: var(--border-size) solid currentcolor;
                border-bottom: var(--border-size) solid currentcolor;
            }
            .button__horizontal::before {
                top: calc(var(--vertical-offset) - var(--border-size));
                bottom: calc(var(--vertical-offset) - var(--border-size));
                left: calc(var(--vertical-offset) * -1);
                right: calc(var(--vertical-offset) * -1);
            }
            .button:hover .button__horizontal {
                -webkit-transform: scaleX(0);
                transform: scaleX(0);
            }
            .button__vertical {
                --horizontal-offset: calc(var(--offset) * -1);
                border-left: var(--border-size) solid currentcolor;
                border-right: var(--border-size) solid currentcolor;
            }
            .button__vertical::before {
                top: calc(var(--horizontal-offset) * -1);
                bottom: calc(var(--horizontal-offset) * -1);
                left: calc(var(--horizontal-offset) - var(--border-size));
                right: calc(var(--horizontal-offset) - var(--border-size));
            }
            .button:hover .button__vertical {
                -webkit-transform: scaleY(0);
                transform: scaleY(0);
            }

            /*Popup move horizontal*/
            @keyframes move-horizontal{
                from {
                    opacity: 0;
                    /* left: 50.3em */
                    top: 50em;
                }
                to {
                    opacity: 1;
                    top: 33.2em;
                    /* left: 68.3em; */
                }
            }
            /* @keyframes scale-form{
              from{
                height: 10%;
                width: 10%;
              }
              to {
                height: 90%;
                width: 90%;
              }
            } */


            /* Button used to open the contact form - fixed at the bottom of the page */
            /* .open-button {
              background-color: #555;
              color: white;
              padding: 16px 20px;
              border: none;
              cursor: pointer;
              opacity: 0.8;
              position: fixed;
              bottom: 23px;
              right: 28px;
              width: 280px;
            } */

            /* The popup form - hidden by default */
            .insert-form-popup {
                display: none;
                position: fixed;
                border: 2px solid #e55743;
                z-index: 9;
/*                top: 33.3em;
                left: 49.8em;
                animation: move-horizontal 0.5s ease-in;*/
            }
            .delete-form-popup {
                display: none;
                position: fixed;
                border: 2px solid #e55743;
                z-index: 9;
/*                top: 33.3em;
                left: 49.8em;
                animation: move-horizontal 0.5s ease-in;*/
            }  
            .update-form-popup {
                display: none;
                position: fixed;
                border: 2px solid #e55743;
                z-index: 9;
/*                left: 49.8em;
                top: 33.3em;
                animation: move-horizontal 0.5s ease-in;*/
            }  
            .view-form-popup {
                display: none;
                position: fixed;
                border: 2px solid #e55743;
                z-index: 9;
/*                left: 49.8em;
                top: 33.3em;
                animation: move-horizontal 0.5s ease-in;*/
            }
            .view-all-form-popup {
                display: none;
                position: fixed;
                border: 2px solid #e55743;
                z-index: 9;
/*                left: 49.8em;
                top: 33.3em;
                animation: move-horizontal 0.5s ease-in;*/
            }

            /* Add styles to the form container */
            .form-container {
                color: #e55743;
                max-width: 300px;
                padding: 10px;
                background: #fcf3ec;
                font-family: 'Montserrat Alternates' ;
                /* animation: scale-form 0.7s ease-in; */
            }

            /* Full-width input fields */
            .form-container input[type=text], .form-container input[type=text] {
                width: 90%;
                height: 90%;
                padding: 15px;
                margin: 5px 0 22px 0;
                border: none;
                background: #fcf3ec;
            }

            /* When the inputs get focus, do something */
            .form-container input[type=text]:focus, .form-container input[type=text]:focus {
                background-color: #ddd;
                outline: none;
            }

            /*Submit Button Animation*/
            /* @keyframes{
              100%, 0%{
              }
              20% {
              }
              40% {
              }
              60% {
              }
            }  */

            /* Set a style for the submit/login button */
            .form-container .btn {
                background-color: #21bf73;
                color: white;
                padding: 16px 20px;
                border: none;
                cursor: pointer;
                width: 100%;
                margin-bottom:10px;
                opacity: 0.5;
            }

            /* Add a red background color to the cancel button */
            .form-container .cancel {
                color: #e55743;
                right: 0px;
            }
            /* Add some hover effects to buttons */
            .form-container .btn:hover, .open-button:hover {
                opacity: 1;
            }

            .btn_cancel{
                margin-top: 10px;
                width: fit-content;
                margin-left: 17.7em;
                border: none;
                background-color: inherit;
                font-size: 16px;
                cursor: pointer;
                display: inline-block;  
                color: #e55743;
            }

            /* .mfp-move-horizontal .mfp-with-anim {
              opacity: 0;
              transition: all 0.3s;
              transform: translateX(-50px);
            }
            .mfp-move-horizontal.mfp-bg {
              opacity: 0;
              transition: all 0.3s;
            }
            .mfp-move-horizontal.mfp-ready .mfp-with-anim {
              opacity: 1;
              transform: translateX(0);
            }
            .mfp-move-horizontal.mfp-ready.mfp-bg {
              opacity: 0.8;
            }
            .mfp-move-horizontal.mfp-removing .mfp-with-anim {
              transform: translateX(50px);
              opacity: 0;
            }
            .mfp-move-horizontal.mfp-removing.mfp-bg {
              opacity: 0;
            }
            .object {
              position: absolute;
              transition: all 2s ease-in-out;
              -webkit-transition: all 2s ease-in-out;
            }
            #axis:hover .move-right{
              transform: translate(350px,0);
              -webkit-transform: translate(350px,0); 
            } */
            td {
                border: black 2px solid;
            }
        </style>
    </head>
    <body>
        
        <div class="menu-wrapper">  
            <div class="insert-form-wrapper">
                <button class="button" onclick="openInsertForm()">
                    Insert
                    <div class="button__horizontal"></div>
                    <div class="button__vertical"></div>
                </button>
                <div class="insert-form-popup" id="myInsertForm">
                    <form name="form1" class="form-container">
                        <button type="submit" class="btn_cancel" onclick="closeInsertForm()" >&#10006;</button> 
                        <h1 style="margin-top: -28px;" >Insert</h1>
                        <hr style="color:#e55743;">
                        <label for="id"><b>ID</b></label><br>
                        <input type="text" placeholder="Enter ID" name="id" required>
                        <input type="hidden" name="operation" value="insert"/>
                        <label for="name"><b>NAME</b></label><br>
                        <input type="text" placeholder="Enter Name" name="name" required>

                        <button onclick="javascript:document.getElementById('form1').submit()" class="btn">Insert</button>
                      
                    </form>
                </div>
            </div>
            <div class="delete-form-wrapper">
                <button class="button" onclick="openDeleteForm()">
                    Delete
                    <div class="button__horizontal"></div>
                    <div class="button__vertical"></div>
                </button>
                <div class="delete-form-popup" id="myDeleteForm">
                    <form id="form1" class="form-container">
                        <button type="submit" class="btn_cancel" onclick="closeDeleteForm()" >&#10006;</button> 
                        <h1 style="margin-top: -28px;" >Delete</h1>
                        <hr style="color:#e55743;">
                        <label for="id"><b>ID</b></label><br>
                        <input type="text" placeholder="Enter ID" name="id" required>
                        <input type="hidden" name="operation" value="delete"/>
<!--                       <label for="name"><b>NAME</b></label><br>
                        <input type="text" placeholder="Enter Name" name="name" required>-->

                        <button onclick="javascript:document.getElementById('form1').submit()" class="btn">Delete</button>
                        <!-- <button type="submit" class="btn cancel" onclick="closeDeleteForm()">Close</button> -->
                    </form>
                </div>
            </div>
            <div class="update-form-wrapper">
                <button class="button" onclick="openUpdateForm()">
                    Update
                    <div class="button__horizontal"></div>
                    <div class="button__vertical"></div>
                </button>
                <div class="update-form-popup" id="myUpdateForm">
                    <form class="form-container">
                        <button type="submit" class="btn_cancel" onclick="closeUpdateForm()" >&#10006;</button> 
                        <h1 style="margin-top: -28px;">Update</h1>
                        <hr style="color:#e55743;">
                        <label for="id"><b>ID</b></label><br>
                        <input type="text" placeholder="Enter ID" name="id" required>
                        <input type="hidden" name="operation" value="update"/>
                        <label for="name"><b>NAME</b></label><br>
                        <input type="text" placeholder="Enter Name" name="name" required>

                        <button onclick="javascript:document.getElementById('form1').submit()" class="btn">Update</button>
                        <!-- <button type="submit" class="btn cancel" onclick="closeUpdateForm()">Close</button> -->
                    </form>
                </div>
            </div>
            <div class="view-form-wrapper">
                <button class="button" onclick="openViewForm()">
                    View
                    <div class="button__horizontal"></div>
                    <div class="button__vertical"></div>
                </button>
                <div class="view-form-popup move-horizontal" id="myViewForm">
                    <form id="form2" class="form-container">
                        <button type="submit" class="btn_cancel" onclick="closeViewForm()">&#10006;</button> 
                        <h1 style="margin-top: -28px;" >View</h1>
                        <hr style="color:#e55743;">
                        <label for="id"><b>ID</b></label><br>
                        <input type="hidden" name="operation" value="viewRecord"/>
                        <input type="text" placeholder="Enter ID" name="id" required>
                        <button onclick="javascript:document.getElementById('form2').submit()" class="btn">View</button>
                    </form>
                </div>
                <div class="view-all-form-wrapper">
                <button class="button" onclick="openViewAllForm()">
                    View All
                    <div class="button__horizontal"></div>
                    <div class="button__vertical"></div>
                </button>
                <div class="view-all-form-popup move-horizontal" id="myViewAllForm">
                    <form id="form2" class="form-container">
                        <button type="submit" class="btn_cancel" onclick="closeViewAllForm()">&#10006;</button> 
                        <h1 style="margin-top: -28px;" >View</h1>
                        <hr style="color:#e55743;">
<!--                        <label for="id"><b>ID</b></label><br>
                        <input type="hidden" name="operation" value="viewRecord"/>
                        <input type="text" placeholder="Enter ID" name="id" required>-->
                        <button onclick="javascript:document.getElementById('form2').submit()" class="btn">View</button>
                    </form>
                </div>
                
                <%
                    DBOperation dop = new DBOperation();
                    KK user = new KK();
                    String oper = (String) request.getParameter("operation");
                    if(oper != null) {
                        if(oper.equals("insert")) {
                            String id = (String) request.getParameter("id");
                            String name = (String) request.getParameter("name");
                            dop.insertRecord(id, name);
                        } else if (oper.equals("update")) {
                            String id = request.getParameter("id");
                            String name = request.getParameter("name");
                            user.setId(id);
                            user.setName(name);
                            dop.UpdateRecord(user);
                        } else if (oper.equals("delete")) {
                            String id = request.getParameter("id");
                            String name = request.getParameter("name");
                            user.setId(id);
                            user.setName(name);
                            dop.DeleteRecord(user);
                        } else if (oper.equals("viewRecord")) { %>
                            <table>
                                <% 
                                    String id = (String) request.getParameter("id");
                                    ResultSet rs = dop.viewRecord(id);
                                    while (rs.next()) {%>
                                        <tr>
                                            <td><%=rs.getString("id")%></td>
                                            <td><%=rs.getString("name")%></td>
                                        </tr>
                                    <%}%>
                            </table>
                        <%} else if (oper.equals("viewAll")) { %>
                            <table>
                                <% 
                                    ResultSet rs = dop.ViewAll();
                                    while (rs.next()) {%>
                                    <tr>
                                        <td><%=rs.getString("id")%></td>
                                        <td><%=rs.getString("name")%></td>
                                    </tr>
                                <%}%>
                            </table>
                        <%}%>
                    <%}%>

            </div>
        </div>
        <script>
            let insertForm = true;
            let deleteForm = true;
            let updateForm = true;
            let viewForm = true;
            let viewAllForm = true;
            function openInsertForm() {
                document.getElementById("myDeleteForm").style.display = "none";
                document.getElementById("myUpdateForm").style.display = "none";
                document.getElementById("myViewForm").style.display = "none";
                document.getElementById("myViewAllForm").style.display = "none";
                deleteForm = true;
                updateForm = true;
                viewForm = true;
                viewAllForm = true;
                if (insertForm) {
                    document.getElementById("myInsertForm").style.display = "block";
                    insertForm = false;
                } else {
                    document.getElementById("myInsertForm").style.display = "none";
                    insertForm = true;
                }
            }
            function closeInsertForm() {
                insertForm = true;
                deleteForm = true;
                updateForm = true;
                viewForm = true;
                viewAllForm = true;
                document.getElementById("myInsertForm").style.display = "none";
            }
            function openDeleteForm() {
                document.getElementById("myInsertForm").style.display = "none";
                document.getElementById("myUpdateForm").style.display = "none";
                document.getElementById("myViewForm").style.display = "none";
                document.getElementById("myViewAllForm").style.display = "none";
                insertForm = true;
                updateForm = true;
                viewForm = true;
                viewAllForm = true;
                if (deleteForm) {
                    document.getElementById("myDeleteForm").style.display = "block";
                    deleteForm = false;
                } else {
                    document.getElementById("myDeleteForm").style.display = "none";
                    deleteForm = true;
                }
            }
            function closeDeleteForm() {
                insertForm = true;
                deleteForm = true;
                updateForm = true;
                viewForm = true;
                viewAllForm = true;
                document.getElementById("myDeleteForm").style.display = "none";
            }
            function openUpdateForm() {
                document.getElementById("myViewForm").style.display = "none";
                document.getElementById("myInsertForm").style.display = "none";
                document.getElementById("myDeleteForm").style.display = "none";
                document.getElementById("myViewAllForm").style.display = "none";
                insertForm = true;
                deleteForm = true;
                viewForm = true;
                viewAllForm = true;
                if (updateForm) {
                    document.getElementById("myUpdateForm").style.display = "block";
                    updateForm = false;
                } else {
                    document.getElementById("myUpdateForm").style.display = "none";
                    updateForm = true;
                }
            }
            function closeUpdateForm() {
                insertForm = true;
                deleteForm = true;
                updateForm = true;
                viewForm = true;
                viewAllForm = true;
                document.getElementById("myUpdateForm").style.display = "none";
            }
            function openViewForm() {
                document.getElementById("myUpdateForm").style.display = "none";
                document.getElementById("myDeleteForm").style.display = "none";
                document.getElementById("myInsertForm").style.display = "none";
                document.getElementById("myViewAllForm").style.display = "none";
                insertForm = true;
                updateForm = true;
                deleteForm = true;
                if (viewForm) {
                    document.getElementById("myViewForm").style.display = "block";
                    viewForm = false;
                } else {
                    document.getElementById("myViewForm").style.display = "none";
                    viewForm = true;
                }
            }
            function closeViewForm() {
                insertForm = true;
                deleteForm = true;
                updateForm = true;
                viewForm = true;
                document.getElementById("myViewForm").style.display = "none";
            }
            function openViewAllForm() {
                document.getElementById("myUpdateForm").style.display = "none";
                document.getElementById("myDeleteForm").style.display = "none";
                document.getElementById("myInsertForm").style.display = "none";
                document.getElementById("myViewForm").style.display = "none";
                insertForm = true;
                updateForm = true;
                deleteForm = true;
                viewForm = true;
                if (viewForm) {
                    document.getElementById("myViewAllForm").style.display = "block";
                    viewAllForm = false;
                } else {
                    document.getElementById("myViewAllForm").style.display = "none";
                    viewAllForm = true;
                }
            }
            function closeViewAllForm() {
                insertForm = true;
                deleteForm = true;
                updateForm = true;
                viewForm = true;
                viewAllForm = true;
                document.getElementById("myViewAllForm").style.display = "none";
            }

// Inline popups
            $('#inline-popups').magnificPopup({
                delegate: 'a',
                removalDelay: 500, //delay removal by X to allow out-animation
                callbacks: {
                    beforeOpen: function () {
                        this.st.mainClass = this.st.el.attr('data-effect');
                    }
                },
                midClick: true // allow opening popup on middle mouse click. Always set it to true if you don't provide alternative source.
            });
        </script>
    </body>
</html>
