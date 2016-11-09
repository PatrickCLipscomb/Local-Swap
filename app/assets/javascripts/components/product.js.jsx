'use strict';

class Product extends BaseComponent {
    constructor(props){
        super(props);
        this._bind('handleDelete', 'handleToggle', 'productRow', 'productForm', 'handleEdit', 'categoryChange', 'userChange', 'catFunc', 'userFunc', 'conditionsArray', 'conditionChange');
        this.state = {
            edit: false,
            categoryID: this.props.category_id,
            userID: this.props.user_id,
            condition: this.props.product.condition
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
        var category_id = this.state.categoryID
        var user_id = this.state.userID
        var condition = this.state.condition
        var id = "products/" + this.props.product.id;
        var data = {
            name: ReactDOM.findDOMNode(this.refs.name).value,
            category_id: category_id,
            user_id: user_id,
            condition: condition
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

    conditionChange(event) {
      this.setState({condition: event.currentTarget.value})
    }

    conditionsArray() {
      return ["Basically Broken", "Worn", "Lightly Used", "Great", "Like New"]
    }

    productRow() {
        var userName = this.userFunc(this.props.users, this.props.product.user_id)
        var catName = this.catFunc(this.props.categories, this.props.product.category_id)
        var condition_text_array = this.conditionsArray()
        return (
            <tr>
                <td>{this.props.product.name}</td>
                <td>{condition_text_array[this.props.product.condition]}</td>
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
            return <option key={user.id - 1000} value={user.id} selected="selected">{user.user_name}</option>
          } else {
            return <option key={user.id} value={user.id}>{user.user_name}</option>
          }
        })
        var categoryOptions = this.props.categories.map((category) => {
          if (category.id === this.props.product.category_id) {
            return <option key={category.id + 1000} value={category.id} selected="selected">{category.name}</option>
          } else {
            return <option key={category.id} value={category.id}>{category.name}</option>
          }
        })
        var conditionOptions = this.conditionsArray().map((condition) => {
          var counter = this.conditionsArray().indexOf(condition)
          if (counter == this.props.product.condition) {
            return <option key={counter} value={counter} selected="selected">{condition}</option>
          } else {
            return <option key={counter} value={counter}>{condition}</option>
          }
        })
        return (
            <tr>
                <td>
                    <input className="form-control" type="text" defaultValue={this.props.product.name} ref="name"/>
                </td>
                <td>
                  <select onChange={this.conditionChange}>
                    {conditionOptions}
                  </select>
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
