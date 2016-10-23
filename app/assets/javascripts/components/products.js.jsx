'use strict';

class Products extends BaseComponent {
    constructor(props) {
        super();
        this._bind('addProduct', 'deleteProduct', 'handleEditProduct');
        this.state = {
            products: props.data
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
            return <Product key={product.id} product={product}
                           handleDeleteProduct={this.deleteProduct} handleEditProduct={this.handleEditProduct} />
        });
        return (
            <div className="products">
                <h2 className="title"> Products </h2>
                <h5 className="title">Add a product</h5>
                
                <hr />
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
