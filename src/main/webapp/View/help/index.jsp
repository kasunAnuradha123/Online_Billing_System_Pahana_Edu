<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pahana Edu BookShop - Help</title>
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-teal-400 to-cyan-600  font-sans">
<div class="absolute inset-0 overflow-hidden">
		<div
			class="absolute -top-4 -left-4 w-72 h-72 bg-purple-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow"></div>
		<div
			class="absolute top-1/2 -right-4 w-72 h-72 bg-pink-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow animation-delay-2000"></div>
		<div
			class="absolute -bottom-8 left-1/2 w-72 h-72 bg-indigo-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow animation-delay-4000"></div>
	</div>
    <!-- Main Wrapper -->
    <div class="flex h-screen">

        <!-- Sidebar -->
          <%@ include file="/components/sidebar.jsp" %>
       

        <!-- Main Content -->
        <div class="flex-1 flex flex-col">
            
           

            
           <div class="flex-1 flex flex-col overflow-y-auto">
    <main class="p-6 flex-1">
      <h1 class="text-3xl font-bold text-white mb-6">Help & Documentation</h1>

      <ul class="max-w-3xl mx-auto mt-8 divide-y divide-white/30 shadow-lg rounded-xl bg-white/10 backdrop-blur-md">
        
        <!-- Accordion Item Example -->
        <li>
          <details class="group">
            <summary class="flex items-center justify-between px-5 py-4 font-medium text-white hover:bg-white/10 rounded-lg transition">
              <span>Billing System</span>
              <svg class="w-5 h-5 text-white transition-transform" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"></path>
              </svg>
            </summary>
            <div class="px-5 pb-4 text-white space-y-2">
              <p><strong>Add Items:</strong> Search and add items to the bill with their quantity and price.</p>
              <p><strong>Quantity Change:</strong> Update the quantity of any item in the bill before finalizing.</p>
              <p><strong>Discount:</strong> Apply  total discount to bills.</p>
              <p><strong>Print Bill:</strong> Generate and print the bill for the customer.</p>
            </div>
          </details>
        </li>

        <!-- Customer Management -->
        <li>
          <details class="group">
            <summary class="flex items-center justify-between px-5 py-4 font-medium text-white hover:bg-white/10 rounded-lg transition">
              <span>Customer Management</span>
              <svg class="w-5 h-5 text-white transition-transform" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"></path>
              </svg>
            </summary>
            <div class="px-5 pb-4 text-white space-y-2">
              <p><strong>Add Customer:</strong> Register new customers with name, address, and contact.</p>
              <p><strong>Update/Delete:</strong> Edit or remove existing customer records.</p>
              <p><strong>Search:</strong> Search customers quickly using ID, name, or contact number.</p>
            </div>
          </details>
        </li>

        <!-- Item Management -->
        <li>
          <details class="group">
            <summary class="flex items-center justify-between px-5 py-4 font-medium text-white hover:bg-white/10 rounded-lg transition">
              <span>Item Management</span>
              <svg class="w-5 h-5 text-white transition-transform" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"></path>
              </svg>
            </summary>
            <div class="px-5 pb-4 text-white space-y-2">
              <p><strong>Add Items:</strong> Add new books or items with name,code , price, and stock.</p>
              <p><strong>Update/Delete:</strong> Edit item details or remove items from inventory.</p>
              <p><strong>Search:</strong> Quickly find items using name or code.</p>
            </div>
          </details>
        </li>

        <!-- Sales & Reports -->
        <li>
          <details class="group">
            <summary class="flex items-center justify-between px-5 py-4 font-medium text-white hover:bg-white/10 rounded-lg transition">
              <span>Sales & Reports</span>
              <svg class="w-5 h-5 text-white transition-transform" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"></path>
              </svg>
            </summary>
            <div class="px-5 pb-4 text-white space-y-2">
              <p><strong>View Sales:</strong> Check all sales records with date, items sold, and total amount.</p>
              <p><strong>Generate Reports:</strong> Produce reports based on date range, customer, or item sales.</p>
              <p><strong>Print/Export:</strong> Print reports for accounting purposes.</p>
            </div>
          </details>
        </li>

      </ul>

      <p class="text-white/80 mt-8 text-center">
        For further assistance, contact the system administrator or refer to the user manual.
      </p>

    </main>
  </div>


        </div>
    </div>

</body>
</html>
