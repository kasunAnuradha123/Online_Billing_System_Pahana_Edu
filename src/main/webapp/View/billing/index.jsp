<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pahana Edu BookShop - Item</title>
<script src="https://cdn.tailwindcss.com"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</head>
<body
	class="min-h-screen bg-gradient-to-br from-teal-400 to-cyan-600 font-sans">
	<div class="absolute inset-0 overflow-hidden">
		<div
			class="absolute -top-4 -left-4 w-72 h-72 bg-purple-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow"></div>
		<div
			class="absolute top-1/2 -right-4 w-72 h-72 bg-pink-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow animation-delay-2000"></div>
		<div
			class="absolute -bottom-8 left-1/2 w-72 h-72 bg-indigo-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse-slow animation-delay-4000"></div>
	</div>

	<div class="flex h-screen relative z-10">
		<%@ include file="/components/sidebar.jsp"%>

		<div class="flex-1 flex flex-col overflow-hidden">
			<header
				class="bg-white/10 backdrop-blur-md border-b border-white/20 p-[18px] animate-fade-in">
				<div class="lg:flex items-center justify-between">
					<div>
						<h1 class="text-3xl font-bold text-white">Billing Management</h1>
						<p class="text-white/70 text-sm mt-1">Manage your bill</p>
					</div>
				</div>
			</header>

			<main class="flex-1 p-6 overflow-y-auto">
				<%
				String successMessage = (String) session.getAttribute("successMessage");
				if (successMessage != null) {
				%>
				<div
					class="fixed top-4 right-4 max-w-sm w-full bg-green-600 border border-green-400 text-green-100 rounded-lg shadow-lg p-4 flex items-center animate-fade-in-out">
					<i class="fas fa-check-circle mr-3 text-green-200 text-lg"></i> <span
						class="flex-1 text-sm font-medium"><%=successMessage%></span>
					<button onclick="this.parentElement.remove()"
						class="ml-3 text-green-200 hover:text-white font-bold">&times;</button>
				</div>
				<%
				session.removeAttribute("successMessage");
				}
				%>

				<!-- Main Content -->
				<div class="grid grid-cols-1 sm:grid-cols-5 gap-2">
					<!-- Items List -->
					<div class="col-start-1 sm:col-span-3">
						<div>
							<input type="text" id="searchBox" name="search"
								placeholder="🔍 Search for an item"
								class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-teal-500 focus:outline-none">
						</div>

						<div class="grid grid-cols-3 gap-6 mt-2">
							<c:forEach var="item" items="${items}">
								<div
									class="bg-white/70 shadow rounded-xl p-4 flex flex-col justify-between min-h-[150px] item-card break-words
                                     data-id="
									${item.id}" data-name="${fn:toLowerCase(item.name)}"
									data-id="${item.id}" data-name="${fn:toLowerCase(item.name)}"
									data-price="${item.sellingPrice}"
									data-code="${fn:toLowerCase(item.itemCode)}">
									<h3 class="text-lg font-semibold truncate"
										title="${item.itemCode}-${item.name}">${item.itemCode}-${item.name}</h3>
									<p class="text-black mb-2">Rs. ${item.sellingPrice}</p>
									<button type="button"
										class="add-to-cart bg-gradient-to-r from-green-400 to-emerald-500 text-white px-3 py-2 rounded-lg hover:from-green-500 hover:to-emerald-600">
										Add to Cart</button>
								</div>
							</c:forEach>
						</div>

						<!-- Pagination -->
						<div
							class="flex items-center justify-between mt-6 text-white/70 text-sm">
							<div>
								Showing <span class="font-medium text-white">${(currentPage-1) * 10 + 1}</span>
								to <span class="font-medium text-white">${currentPage * 10 > totalItems ? totalItems : currentPage * 10}</span>
								of <span class="font-medium text-white">${totalItems}</span>
								results
							</div>
							<div class="flex items-center space-x-2">
								<c:if test="${currentPage > 1}">
									<a href="BillingServlet?page=${currentPage - 1}"
										class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20">
										<i class="fas fa-chevron-left"></i>
									</a>
								</c:if>
								<c:forEach begin="1" end="${totalPages}" var="i">
									<a href="BillingServlet?page=${i}"
										class="px-4 py-2 ${i == currentPage ? 'bg-gradient-to-br from-teal-100 to-cyan-600 text-white' : 'bg-white/10 border border-white/20 text-white hover:bg-white/20'} rounded-lg font-medium">
										${i} </a>
								</c:forEach>
								<c:if test="${currentPage < totalPages}">
									<a href="BillingServlet?page=${currentPage + 1}"
										class="px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white hover:bg-white/20">
										<i class="fas fa-chevron-right"></i>
									</a>
								</c:if>
							</div>
						</div>
					</div>

					<!-- Cart Section -->
					<div class="col-start-4 sm:col-span-2">
						<div class="bg-white/70 shadow-md rounded-xl p-6">
							<h2 class="text-xl font-semibold mb-4">Billing Cart</h2>

							<!-- Customer Selection -->
							<div class="flex justify-between mb-4">
								<div class="relative  mb-4">
									<input type="text" id="customerSearch"
										placeholder=" 🔍 Search Customer..."
										class="flex-1 border rounded-lg px-3 py-2 w-[290px] focus:ring-2 focus:ring-cyan-500 focus:outline-none">
									<div id="customerResults"
										class="absolute left-0 right-0 bg-white/90 max-h-48 overflow-y-auto border rounded-lg mt-1 hidden z-50"></div>
								</div>



								<button
									class="bg-gradient-to-r from-cyan-500 to-teal-500 text-white px-3 h-10 rounded-lg hover:from-cyan-600 hover:to-teal-600">Add
									New</button>
							</div>
							<div id="selectedCustomer" class="p-2 text-sm text-black "></div>

							<div class="divide-y max-h-60 overflow-auto p-2 space-y-2">
								<div id="cart-items" class="divide-y "></div>

							</div>

							<!-- Totals -->
							<div class="mt-6 border-t pt-4 space-y-2">
								<div class="flex justify-between">
									<span>Sub Total</span> <span id="subtotal">0.00</span>
								</div>
								<div class="flex justify-between">
									<span>Discount</span> <input type="number" id="discount"
										placeholder="Enter discount"
										class=" border w-[150px] rounded-lg px-3 py-2 focus:ring-2 focus:ring-cyan-500 focus:outline-none">
								</div>
								<div
									class="flex justify-between text-xl font-bold text-cyan-600">
									<span>Total</span> <span id="nettotal">0.00</span>
								</div>
							</div>

							<!-- Checkout Button -->
							<button
								class="mt-6 w-full bg-gradient-to-r from-teal-500 to-cyan-600 text-white px-4 py-3 rounded-lg text-lg font-semibold hover:from-teal-600 hover:to-cyan-700">
								Save & Print</button>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>

	<script>
// Item search filter
document.getElementById('searchBox').addEventListener('input', function () {
    let searchValue = this.value.toLowerCase().trim();
    let items = document.querySelectorAll('.item-card');

    items.forEach(item => {
        let name = item.dataset.name;
        let code = item.dataset.code;
        item.style.display = (name.includes(searchValue) || code.includes(searchValue)) ? 'flex' : 'none';
    });
});

// Billing cart
let cart = [];

// Add to Cart
document.querySelectorAll('.add-to-cart').forEach(btn => {
    btn.addEventListener('click', function() {
        const card = this.closest('.item-card');
        const id = card.dataset.id;
        const name = card.dataset.name;
        const price = parseFloat(card.dataset.price);

        const existing = cart.find(i => i.id === id);
        if (existing) {
            existing.qty += 1;
        } else {
            cart.push({ id, name, price, qty: 1 });
        }
        renderCart();
    });
});

//Render Cart using DOM elements with qty input and remove button
function renderCart() {
    const container = document.getElementById('cart-items');
    container.innerHTML = '';

    let subtotal = 0;
    cart.forEach(item => {
        const lineTotal = item.price * item.qty;
        subtotal += lineTotal;

        const itemDiv = document.createElement('div');
        itemDiv.className = 'flex justify-between items-center py-2';

        const leftDiv = document.createElement('div');
        const nameP = document.createElement('p');
        nameP.className = 'font-medium capitalize';
        nameP.textContent = item.name;

        const qtyDiv = document.createElement('div');
        qtyDiv.className = 'flex items-center space-x-2 mt-1';

        const qtyInput = document.createElement('input');
        qtyInput.type = 'number';
        qtyInput.min = 1;
        qtyInput.value = item.qty;
        qtyInput.className = 'qty-input border w-16 h-8 rounded px-2 text-center';
        qtyInput.dataset.id = item.id;

        const removeBtn = document.createElement('button');
        removeBtn.textContent = 'Remove';
        removeBtn.className = 'px-2 py-1 text-white bg-red-500 rounded hover:bg-red-600 rounded-md';
        removeBtn.dataset.id = item.id;

        qtyDiv.appendChild(qtyInput);
        qtyDiv.appendChild(removeBtn);

        leftDiv.appendChild(nameP);
        leftDiv.appendChild(qtyDiv);

        const rightP = document.createElement('p');
        rightP.className = 'font-semibold';
        rightP.textContent = 'Rs. ' + lineTotal.toFixed(2);

        itemDiv.appendChild(leftDiv);
        itemDiv.appendChild(rightP);

        container.appendChild(itemDiv);
    });

    document.getElementById('subtotal').textContent = "Rs. " + subtotal.toFixed(2);
    updateTotal();
}

// Qty input change
document.getElementById('cart-items').addEventListener('input', function(e) {
    if (e.target.classList.contains('qty-input')) {
        const id = e.target.dataset.id;
        const newQty = parseInt(e.target.value);
        if (newQty > 0) {
            const item = cart.find(i => i.id === id);
            if (item) {
                item.qty = newQty;
                renderCart();
            }
        }
    }
});

// Remove item from cart
document.getElementById('cart-items').addEventListener('click', function(e) {
    if (e.target.tagName === 'BUTTON' && e.target.textContent === 'Remove') {
        const id = e.target.dataset.id;
        cart = cart.filter(i => i.id !== id);
        renderCart();
    }
});


// Discount & Net Total
document.getElementById('discount').addEventListener('input', updateTotal);

function updateTotal() {
    const subtotal = cart.reduce((sum, i) => sum + i.price * i.qty, 0);
    const discount = parseFloat(document.getElementById('discount').value) || 0;
    let net = subtotal - discount;
    if (net < 0) net = 0;
    document.getElementById('nettotal').textContent = "Rs. " + net.toFixed(2);
}
//getCustomers
// Get customers from JSP
var customers = [
    <c:forEach var="cust" items="${customers}" varStatus="status">
        {
            id: "${cust.id}",
            accountNumber: "${cust.accountNumber}",
            name: "${cust.name}",
            TP: "${cust.TP}",
            address: "${cust.address}"
        }<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];


// Search and select customer
const searchInput = document.getElementById('customerSearch');
const resultsDiv = document.getElementById('customerResults');
const selectedDiv = document.getElementById('selectedCustomer');

searchInput.addEventListener('input', function() {
    const query = this.value.toLowerCase().trim();
    resultsDiv.innerHTML = '';
    if (!query) {
        resultsDiv.classList.add('hidden');
        return;
    }
    
    // Fixed: use c.TP instead of c.contact
    const matched = customers.filter(c => 
    (c.name && c.name.toLowerCase().includes(query.toLowerCase())) ||
    (c.TP && c.TP.toString().includes(query)) ||
    (c.accountNumber && c.accountNumber.toLowerCase().includes(query.toLowerCase()))
);

    
    if (matched.length === 0) {
        resultsDiv.innerHTML = '<div class="p-2 text-gray-600">No results</div>';
    } else {
        matched.forEach(c => {
            const div = document.createElement('div');
            div.textContent = c.name + ' (' + c.accountNumber + ')';
            div.className = 'p-2 cursor-pointer hover:bg-cyan-500 hover:text-white';
            div.dataset.id = c.id;
            div.dataset.accountNumber = c.accountNumber;
            div.dataset.name = c.name;
            div.dataset.tp = c.TP;
            div.dataset.address = c.address;

            div.addEventListener('click', function() {
                searchInput.value = c.name;
                console.log(c)
                selectedDiv.innerHTML = `
                	<div class="bg-cyan-50 p-4 rounded-lg shadow-sm border border-cyan-200">
                    <h3 class="text-lg font-semibold text-cyan-700 mb-2">Selected Customer</h3>
                    <p><span class="font-medium">Account Number:</span> \${c.accountNumber}</p>
                    <p><span class="font-medium">Name:</span> \${c.name}</p>
                    <p><span class="font-medium">Contact:</span> \${c.TP}</p>
                    <p><span class="font-medium">Address:</span> \${c.address}</p>
                </div>
                
                `;
                
                resultsDiv.classList.add('hidden');
            });
            resultsDiv.appendChild(div);
        });
    }
    resultsDiv.classList.remove('hidden');
});


// Close results if click outside
document.addEventListener('click', function(e) {
    if (!searchInput.contains(e.target) && !resultsDiv.contains(e.target)) {
        resultsDiv.classList.add('hidden');
    }
});

</script>
</body>
</html>
