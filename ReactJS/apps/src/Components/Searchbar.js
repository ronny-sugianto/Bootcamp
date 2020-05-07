import React from 'react'

class SearchBar extends React.Component {
    state = {
        searchKeyword: ''
    };
    onFormSubmit = (event) => {
        event.preventDefault();
        //console.log(this.state.searchKeyword);
        this.props.onSubmit(this.state.searchKeyword);
    }
    onInputChange = (event) => {
        this.setState({ searchKeyword: event.target.value });
    }
    render() {

        return (<form onSubmit={this.onFormSubmit}>
            <div class='form-group'>

                <input type='text' class='form-control' id='searchBar' placeholder='Search Image' onChange={this.onInputChange} />

            </div></form>)
    }
}

export default SearchBar;