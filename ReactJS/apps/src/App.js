import React from 'react';
import './App.css';
import { BrowserRouter, Link, Route } from 'react-router-dom'
import Header from './Components/Header';
import SearchBar from './Components/Searchbar';
import { render } from '@testing-library/react';
import ImageList from './Components/ImageList';





class App extends React.Component {
  state = {
    image: []
  }

  onSearchSubmit = async (term) => {
    const response = await fetch(`https://jsonplaceholder.typicode.com/photos?id=${term}`, {
      method: 'GET'
    });
    const data = await response.json();
    if (data.length > 0) {
      this.setState({ image: data })
    } else {
      console.log('Tidak Ada Gambar');
    }

  }

  render() {
    return (
      <div className='container'>
        <Header />
        <SearchBar onSubmit={this.onSearchSubmit} />
        <p>Found {this.state.image.length} images</p>
        <ImageList images={this.state.image} />
      </div>
    );
  };

}

export default App;
