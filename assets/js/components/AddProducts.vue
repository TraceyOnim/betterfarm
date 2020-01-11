<template>
	<!-- <div>
	<form action="" method="" enctype="multipart/formdata">
	<div class="form-group">
		<label>Product Name</label>
		<select class="form-control">
			<option value="">select product name</option>
		</select>
	</div>
	<div class="form-group">
		<%= label f, :price, "Price"%>
		<%= text_input f, :price, class: "form-control"%>
		<%= error_tag f, :price%>
	</div>
	<div class="form-group">
		<%= label f, :location, "Location"%>
		<%= text_input f, :location, class: "form-control" %>
		<%= error_tag f, :location%>
	</div>
	<div class="row">
	<div class="form-group col-xs-6">
		<%= label f, :quantity, "Quantity"%>
		<%= text_input f, :quantity, class: "form-control" %>
		<%= error_tag f, :quantity %>
	</div>
	<div class="form-group col-xs-6">
		<%= label f, :unit, "Unit"%>
		<%= select f, :unit, [kg: "kg", grams: "grams"], class: "form-control"%>
		
	</div>

	</div>

	<div class="form-group">
		<%= label f, :category, "Category"%>
		<%= select f, :category, category_name(), prompt: "select category", class: "form-control" %>
		
	</div>
	<div class="form-group">
		<%= label f, :description, "Description"%>
		<%= textarea f, :description, class: "form-control"%>
		
	</div>
	<div>
		<%=label f, :image, "Upload image of the product"%>
		<%= file_input f , :image, multiple: true, class: "file-input form-control", id: "file"%>
	</div>


	<%= submit "Add Product", class: "btn btn-info"%>
	<% end %>
</div> -->
</template>

<script>
	export default {
		props: ['token'],
		methods: {
			addProduct(){
				axios.post('/farmers/1/products', {})
				.then(response => {
					console.log(response.data)
				})
				.catch(error => {
					console.log(error.response)
				})
			}
		},
		mounted(){
			this.addProduct();
		}
	}
</script>