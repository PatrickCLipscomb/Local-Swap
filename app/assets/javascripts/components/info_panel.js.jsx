'use strict';

class InfoPanel extends React.Component {
  constructor(props) {
    super()
  }
  render() {
      return (
          <div className="pull-right">
              <div className="panel panel-warning" >
                  <div className="panel-heading">
                    <h3 className="black-info-header">Local Swap Object Status</h3>
                  </div>
                  <div className="panel-body">
                    <p className="black-info-header">There are currently:</p>
                    <p className="black-info-text">{ this.props.userNumber } Users</p>
                    <p className="black-info-text"> { this.props.productNumber } Products</p>
                    <p className="black-info-text"> { this.props.categoryNumber } Categories</p>
                    <p className="black-info-text"> { this.props.reviewNumber } Reviews</p>
                  </div>
              </div>
          </div>
      );
  }
}
