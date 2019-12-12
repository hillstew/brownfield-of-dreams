import { Controller } from 'stimulus';

export default class extends Controller {
  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute('content');
  }

  addBookmark(event) {
    const { id } = event.target;
    fetch(this.data.get('bookmark-url'), {
      body: { id },
      method: 'POST',
      headers: {
        'X-CSRF-Token': this.getMetaValue('csrf-token')
      }
    })
      .then(function(response) {
        if (response.status != 200) {
          console.log(response);
        }
      })
      .catch(function(error) {
        console.log(error);
      });
  }

  showDescription(event) {
    event.preventDefault();
    fetch(`/api/v1/videos/${event.target.id}`)
      .then(response => response.json())
      .then(function(response) {
        const desc = document.querySelector(`#description-${event.target.id}`);
        desc.innerHTML = response.description;
      });
  }

  showVideoForm(event) {
    event.preventDefault();

    var elem = document.getElementById('new-video-form');
    var getHeight = function() {
      elem.style.display = 'block';
      var height = elem.scrollHeight + 'px';
      elem.style.display = '';
      return height;
    };

    var height = getHeight();
    elem.classList.add('is-visible');
    elem.style.height = height;

    window.setTimeout(function() {
      elem.style.height = '';
    }, 350);
  }

  updateOrder(event) {
    event.preventDefault();
    fetch(`/admin/api/v1/tutorial_sequencer/${event.target.id}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json; charset=utf-8'
      },
      body: JSON.stringify(sortable.toArray())
    })
      .then(response => response.json())
      .then(function(response) {
        console.log('hello');
      });
  }
}
