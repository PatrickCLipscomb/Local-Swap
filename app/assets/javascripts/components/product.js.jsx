'use strict';

class Product extends BaseComponent {
    constructor(props){
        super(props);
        this._bind('handleDelete', 'handleToggle', 'productRow', 'productForm', 'handleEdit');
        this.state = {
            edit: false
        };
    }

    handleDelete(event) {
        var id = "products/" + this.props.product.id;
        event.preventDefault();
        $.ajax({
            method: 'DELETE',
            url: id,
            dataType: 'JSON',
            success: ( () => {
                this.props.handleDeleteProduct(this.props.product);
            })
        });
    }

    handleEdit(event) {
        event.preventDefault();
        var id = "products/" + this.props.product.id;
        var data = {
            name: ReactDOM.findDOMNode(this.refs.name).value,
            price: ReactDOM.findDOMNode(this.refs.price).value,
        };
        $.ajax({
            method: 'PUT',
            url: id,
            dataType: 'JSON',
            data: { product: data },
            success: ( (data) => {
                this.setState({ edit: false });
                this.props.handleEditProduct(this.props.product, data);
            })
        });
    }

    handleToggle(event) {
        event.preventDefault();
        this.setState({ edit: !this.state.edit });
    }

    productRow() {
        return (
            <tr>
                <td>{this.props.product.name}</td>
                <td>{this.props.product.price}</td>
                <td>{this.props.product.category_id}</td>
                <td>{this.props.product.user_id}</td>
                <td>
                    <a className="btn btn-default" onClick={this.handleToggle}>Edit</a>
                    <a className="btn btn-danger" onClick={this.handleDelete}>Delete</a>
                </td>
            </tr>
        );
    }

    productForm() {
        return (
            <tr>
                <td>
                    <input className="form-control" type="text" defaultValue={this.props.product.name} ref="name"/>
                </td>
                <td>
                    <input className="form-control" type="number" defaultValue={this.props.product.price} ref="price"/>
                </td>
                <td>
                    {this.props.product.category_id}
                </td>
                <td>
                    {this.props.product.user_id}
                </td>
                <td>
                    <a className="btn btn-default" onClick={this.handleEdit}>Update</a>
                    <a className="btn btn-danger" onClick={this.handleToggle}>Cancel</a>
                </td>
            </tr>
        );
    }

    render() {
        return this.state.edit ? this.productForm() : this.productRow();
    }
}

Product.propTypes = {
    product: React.PropTypes.object.isRequired,
    handleDeleteProduct: React.PropTypes.func.isRequired,
    handleEditProduct: React.PropTypes.func.isRequired
};
