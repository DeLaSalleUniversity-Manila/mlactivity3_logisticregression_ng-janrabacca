  x = load('x.dat'); 
  y = load('y.dat');
  [m, n] = size(x);
  x = [ones(m, 1), x]; 
  pos = find(y); neg = find(y == 0);
  plot(x(pos, 2), x(pos,3), '+')
  hold on
  plot(x(neg, 2), x(neg, 3), 'o')
  hold on
  theta = zeros(n+1, 1);
  g = inline('1.0 ./ (1.0 + exp(-z))'); 
  iter= 30;
  J = zeros(iter, 1);
    for i = 1:iter
      z = x * theta;
      h = g(z);
      grad = ((1/m).*x' * (h-y));
      H = ((1/m).*x' * diag(h) * diag(1-h) * x);
      J(i) =(1/m)*sum(-y.*log(h) - (1-y).*log(1-h));
      theta = theta - H\grad;
  end
  theta
  plot_x = [min(x(:,2))-2,  max(x(:,2))+2];
  plot_y = (-1./theta(3)).*(theta(2).*plot_x +theta(1));
  plot(plot_x, plot_y)
  plot_x = [min(x(:,2))-2,  max(x(:,2))+2];
  hold off
  plot(0:iter-1, J, 'o--')
  