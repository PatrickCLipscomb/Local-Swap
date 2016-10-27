'use strict';


var initialState = {
    name: '',
    price: '',
    user_id: 1,
    category_id: 1
};

class ProductForm extends BaseComponent {
    constructor(props) {
        super(props);
        this._bind('handleChange', 'valid', 'handleSubmit');
        this.state = initialState;
    }

    handleChange(event) {
        var name = event.target.name;
        var obj = {};
        obj[""+name] = event.target.value;
        this.setState(obj);
    }

    valid() {
        return this.state.title && this.state.date && this.state.amount;
    }

    handleSubmit(event) {
        event.preventDefault();
        $.post('', {product: this.state}, (data) => {
            this.props.handleNewProduct(data);
            this.setState(initialState);
        });
    }




    render() {
        return (
            <form className="form-inline" onSubmit={this.handleSubmit}>
                <div className="form-group">
                    <input type="text" className="form-control" placeholder="Date"
                           name="date" value={this.state.date} onChange={this.handleChange} />
                </div>
                <div className="form-group">
                    <input type="text" className="form-control" placeholder="Title"
                           name="title" value={this.state.title} onChange={this.handleChange} />
                </div>
                <div className="form-group">
                    <input type="number" className="form-control" placeholder="Amount"
                           name="amount" value={this.state.amount} onChange={this.handleChange} />
                </div>
                <button type="submit" className="btn btn-primary" disabled={!this.valid}>
                    Create Product
                </button>
            </form>
        );
    }
}

ProductForm.propTypes = {
    handleNewProduct: React.PropTypes.func.isRequired
};
