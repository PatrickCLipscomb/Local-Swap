'use strict';

class Product extends BaseComponent {
    constructor(props){
        super(props);
        this._bind('handleDelete', 'handleToggle', 'productRow', 'productForm', 'handleEdit', 'categoryChange', 'userChange', 'catFunc', 'userFunc');
        this.state = {
            edit: false,
            categoryID: this.catFunc(this.props.categories, this.props.product.category_id),
            userID: this.userFunc(this.props.users, this.props.product.user_id)
        };
    }

    userFunc(users, product_user_id) {
      var userName;
      users.forEach(function(userObj) {
        if (userObj.id === product_user_id) {
          userName = userObj.user_name;
        }
      })
      return userName
    }

    catFunc(cat, product_cat_id) {
      var catName;
      cat.forEach(function(catObj) {
        if (catObj.id === product_cat_id) {
          catName = catObj.name;
        }
      })
      return catName
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
        console.log(this.state.userID)
        var category_id = this.state.categoryID
        var user_id = this.state.userID
        var id = "products/" + this.props.product.id;
        var data = {
            name: ReactDOM.findDOMNode(this.refs.name).value,
            price: ReactDOM.findDOMNode(this.refs.price).value,
            category_id: category_id,
            user_id: user_id
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

    categoryChange(event) {
      this.setState({categoryID: event.currentTarget.value})
    }

    userChange(event) {
      this.setState({userID: event.currentTarget.value})
    }

    productRow() {
        var userName = this.userFunc(this.props.users, this.props.product.user_id)
        var catName = this.catFunc(this.props.categories, this.props.product.category_id)
        return (
            <tr>
                <td>{this.props.product.name}</td>
                <td>{this.props.product.price}</td>
                <td>{catName}</td>
                <td>{userName}</td>
                <td>
                    <a className="btn btn-default glyphicon glyphicon-pencil inline-glyph" onClick={this.handleToggle}></a>
                    <a className="btn btn-danger glyphicon glyphicon-trash inline-glyph" onClick={this.handleDelete}></a>
                </td>
            </tr>
        );
    }

    productForm() {
        var userOptions = this.props.users.map((user) => {
          if (user.id === this.props.product.user_id) {
            return <option key={user.id} value={user.id} selected="selected">{user.user_name}</option>
          } else {
            return <option key={user.id} value={user.id}>{user.user_name}</option>
          }
        })
        var categoryOptions = this.props.categories.map((category) => {
          if (category.id === this.props.product.category_id) {
            return <option key={category.id} value={category.id} selected="selected">{category.name}</option>
          } else {
            return <option key={category.id} value={category.id}>{category.name}</option>
          }
        })
        return (
            <tr>
                <td>
                    <input className="form-control" type="text" defaultValue={this.props.product.name} ref="name"/>
                </td>
                <td>
                    <input className="form-control" type="number" defaultValue={this.props.product.price} ref="price"/>
                </td>
                <td>
                  <select onChange={this.categoryChange}>
                    {categoryOptions}
                  </select>
                </td>
                <td>
                  <select onChange={this.userChange}>
                    {userOptions}
                  </select>
                </td>
                <td>
                    <a className="btn btn-default glyphicon glyphicon-ok inline-glyph" onClick={this.handleEdit}></a>
                    <a className="btn btn-danger glyphicon glyphicon-remove inline-glyph" onClick={this.handleToggle}></a>
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
