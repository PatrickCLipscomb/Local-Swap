'use strict';

class Products extends BaseComponent {
    constructor(props) {
        super();
        this._bind('addProduct', 'deleteProduct', 'handleEditProduct');
        this.state = {
            products: props.data[0],
            users: props.data[1],
            categories: props.data[2]
        };
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

    render() {
        var products = this.state.products.map((product, index) => {
            return <Product key={product.id} product={product} users={this.state.users} categories={this.state.categories} handleDeleteProduct={this.deleteProduct} handleEditProduct={this.handleEditProduct} />
        });
        return (
            <div className="products">
                <h2 className="title"> Products Admin Edit Board </h2>
                <h5 className="title">Add a product</h5>

                <table className="table table-bordered">
                    <thead>
                        <tr>
                            <th> Name </th>
                            <th> Price </th>
                            <th> Category </th>
                            <th> User </th>
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
