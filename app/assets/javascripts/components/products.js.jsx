'use strict';

class Products extends BaseComponent {
    constructor(props) {
        super();
        this._bind('addProduct', 'deleteProduct', 'handleEditProduct', 'handleCategorySelect', 'handleUserSelect', 'filterFunction');
        this.state = {
            products: props.data[0],
            users: props.data[1],
            categories: props.data[2],
            reviews: props.data[3],
            selectedCategoryID: 'All',
            selectedUserID: 'All'
        };
    }

    handleCategorySelect(event) {
      var categoryID = event.currentTarget.value
      this.setState({selectedCategoryID: categoryID})
    }

    handleUserSelect(event) {
      var userID = event.currentTarget.value
      this.setState({selectedUserID: userID})
    }

    addProduct(product) {
        var products = React.addons.update(this.state.products, {$push: [product]});
        this.setState({ products: products });
    }

    deleteProduct(product) {
        var index = this.state.products.indexOf(product);
        var products = React.addons.update(this.state.products, {$splice: [[index, 1]]});
        this.setState({ products: products });
    }

    handleEditProduct(product, data) {
        var index = this.state.products.indexOf(product);
        var products = React.addons.update(this.state.products, {$splice: [[index, 1, data]]});
        this.setState({ products: products} );
    }

    filterFunction() {
      var currentCategoryID = this.state.selectedCategoryID
      var currentUserID = this.state.selectedUserID
      var chosenProducts = [];
      var chosenProductsFinal = [];
      this.state.products.forEach(function(product) {
        if (currentCategoryID === "All") {
          chosenProducts.push(product)
        } else if (product.category_id === parseInt(currentCategoryID)) {
          chosenProducts.push(product)
        }
      })
      chosenProducts.forEach(function(product) {
        if (currentUserID === "All") {
          chosenProductsFinal.push(product)
        } else if (product.user_id === parseInt(currentUserID)) {
          chosenProductsFinal.push(product)
        }
      })
      return chosenProductsFinal
    }

    userFilter() {
      var currentUserID = this.state.selectedUserID
      var chosenProducts = [];
    }

    render() {
        var products = this.filterFunction().map((product, index) => {
            var swag_key = index + 55667;
            return <Product key={swag_key} product={product} users={this.state.users} categories={this.state.categories} handleDeleteProduct={this.deleteProduct} handleEditProduct={this.handleEditProduct} />
        });
        var categories = this.state.categories.map((category) => {
          return <option value={category.id}>{category.name}</option>
        })
        var users = this.state.users.map((user) => {
          return <option value={user.id}>{user.user_name}</option>
        })
        return (
            <div className="products">
              <div className="row">
                <div className="col-md-offset-8 col-md-4">
                  <InfoPanel productNumber={this.state.products.length} userNumber={this.state.users.length} categoryNumber={this.state.categories.length} reviewNumber={this.state.reviews.length} />
                </div>
              </div>
                <h2 className="title"> Admin Product Management Dashboard</h2>
                <hr />
                <table className="table table-bordered">
                    <thead>
                        <tr>
                            <th> Name </th>
                            <th> Condition </th>
                            <th> Category
                              <br />
                              <select className="orange-background" onChange={this.handleCategorySelect}>
                                <option value="All">All Categories</option>
                                {categories}
                              </select>
                            </th>
                            <th> User
                              <br />
                              <select className="orange-background" onChange={this.handleUserSelect}>
                                <option value="All">All Users</option>
                                {users}
                              </select>
                            </th>
                            <th> Actions </th>
                        </tr>
                    </thead>
                    <tbody>
                    {products}
                    </tbody>
                </table>
            </div>
        );
    }
}

Products.defaultProps = {
    products: []
};
